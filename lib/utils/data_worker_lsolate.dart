import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

final gzipDecoder = GZipDecoder();
const utf8Decoder = Utf8Decoder();

// Must be top-level function
dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

///用于单次解析大json
dynamic parseJsonByOnce(String text) {
  return compute(_parseAndDecode, text);
}

///http用于多次解析大json
dynamic parseJsonForHttp(String data) {
  if (DataWorkerIsolate._instance.isFinish) {
    return DataWorkerIsolate._instance.parseJson(data);
  } else {
    return null;
  }
}

///webSocket用于多次解析大json
dynamic parseJsonForWs(Object data) {
  return DataWorkerIsolate._instance.parseJson(data);
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
      if (message is String) {
        final int code = message.hashCode;
        final dynamic json = jsonDecode(message);
        final IsoWorkResult isoWorkResult = IsoWorkResult();
        isoWorkResult.code = code;
        isoWorkResult.result = json;
        sendPort.send(isoWorkResult);
      } else if (message is List<int>) {
        final int code = md5.convert(message).hashCode;
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

  debugPrint(
      "jsonParser isolate = ${Isolate.current.debugName} isolateWorker finish");
}

class DataWorkerIsolate {
  static final DataWorkerIsolate _instance = DataWorkerIsolate._internal();
  final Map<int, Completer<dynamic>> _callback = <int, Completer<dynamic>>{};

  Isolate _isolate;
  ReceivePort _incomingReceivePort;
  SendPort _outgoingSendPort;
  bool _isFinish;

  bool get isFinish => _isFinish == true;

  factory DataWorkerIsolate() {
    return _instance;
  }

  ///构造函数
  DataWorkerIsolate._internal() {
    _createIsolate();
    _listen();
  }

  Future<dynamic> parseJson(Object data) {
    if (data == null) return Future.value();
    final Completer<dynamic> completer = Completer<dynamic>();

    int code;
    if (data is List<int>) {
      code = md5.convert(data).hashCode;
    } else {
      code = data.hashCode.hashCode;
    }

    _callback[code] = completer;
    _outgoingSendPort.send(data);
    return completer.future;
  }

  Future<void> _createIsolate() async {
    _incomingReceivePort = ReceivePort();
    _isolate = await Isolate.spawn(
        _isolateWorker, _incomingReceivePort.sendPort,
        debugName: "jsonParser");
  }

  Future<void> _listen() async {
    _incomingReceivePort.listen((message) {
      if (message is SendPort) {
        _outgoingSendPort = message;
        _isFinish = true;
        debugPrint(
            "jsonParser isolate = ${Isolate.current.debugName} is finish");
      } else if (message is IsoWorkResult) {
        final int code = message.code;
        final dynamic result = message.result;
        final Completer<dynamic> completer = _callback[code];

        if (completer != null && !completer.isCompleted) {
          completer.complete(result);
        }
        _callback.remove(code);
      }
    });
  }

  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }
}
