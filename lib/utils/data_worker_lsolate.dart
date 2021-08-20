import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';

final gzipDecoder = GZipDecoder();
const utf8Decoder = Utf8Decoder();

// Must be top-level function
dynamic parseAndDecode(String response) {
  return jsonDecode(response);
}

///用于单次解析大json
dynamic parseJsonByOnce(String text) {
  return compute(parseAndDecode, text);
}

///用于多次解析大json
dynamic parseJsonByLoop(Object data) {
  return DataWorkerIsolate.instance.parseJson(data);
}

class IsoWorkResult {
  int code;
  dynamic result;
}

Future<void> _isolateWorker(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  receivePort.listen(
    (message) async {
      final int code = message.hashCode;
      if (message is String) {
        final dynamic json = jsonDecode(message);
        final IsoWorkResult isoWorkResult = IsoWorkResult();
        isoWorkResult.code = code;
        isoWorkResult.result = json;
        sendPort.send(isoWorkResult);
      } else if (message is List<int>) {
        try {
          final decodedBytes = gzipDecoder.decodeBytes(message);
          final String jsonStr = utf8Decoder.convert(decodedBytes);

          final dynamic json = jsonDecode(jsonStr);
          final IsoWorkResult isoWorkResult = IsoWorkResult();
          isoWorkResult.code = code;
          isoWorkResult.result = json;
          sendPort.send(isoWorkResult);
        } catch (e) {
          //有异常，则改用二进制解析
          final String jsonStr = utf8Decoder.convert(message);
          final dynamic json = jsonDecode(jsonStr);
          final IsoWorkResult isoWorkResult = IsoWorkResult();
          isoWorkResult.code = code;
          isoWorkResult.result = json;
          sendPort.send(isoWorkResult);
        }
      }
    },
  );
}

class DataWorkerIsolate {
  static final DataWorkerIsolate instance = DataWorkerIsolate._internal();

  Isolate _isolate;
  ReceivePort _incomingReceivePort;
  SendPort _outgoingSendPort;
  Map<int, Completer<dynamic>> callback;

  factory DataWorkerIsolate() {
    return instance;
  }

  ///构造函数
  DataWorkerIsolate._internal() {
    callback = <int, Completer<dynamic>>{};
    _createIsolate();
    _listen();
  }

  Future<dynamic> parseJson(Object data) {
    if (data == null) return Future.value();
    final Completer<dynamic> completer = Completer<dynamic>();
    callback[data.hashCode] = completer;
    _outgoingSendPort.send(data);
    return completer.future;
  }

  Future<void> _createIsolate() async {
    _incomingReceivePort = ReceivePort();
    _isolate =
        await Isolate.spawn(_isolateWorker, _incomingReceivePort.sendPort);
  }

  Future<void> _listen() async {
    _incomingReceivePort.listen((message) {
      if (message is SendPort) {
        _outgoingSendPort = message;
      } else if (message is IsoWorkResult) {
        final int code = message.code;
        final dynamic result = message.result;
        final Completer<dynamic> completer = callback[code];

        if (completer != null && !completer.isCompleted) {
          completer.complete(result);
        }
      }
    });
  }

  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }
}
