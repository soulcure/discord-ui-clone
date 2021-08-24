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
  if (DataWorkerIsolate.instance._outgoingSendPort != null) {
    return DataWorkerIsolate.instance.parseJson(data);
  } else {
    return null;
  }
}

class IsoWorkResult {
  int code;
  dynamic result;
}

Future<void> _isolateWorker(SendPort sendPort) async {
  final ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);

  debugPrint("yao isolateWorker start, iso name=${Isolate.current.debugName}");
  receivePort.listen(
    (message) async {
      debugPrint(
          "yao isolateWorker receive message type=${message.runtimeType}, iso name=${Isolate.current.debugName}");

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
  debugPrint("yao isolateWorker end, iso name=${Isolate.current.debugName}");
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
    debugPrint("yao main iso DataWorker isolate create start");
    callback = <int, Completer<dynamic>>{};
    _createIsolate();
    _listen();
    debugPrint("yao main iso DataWorker isolate create finish");
  }

  Future<dynamic> parseJson(Object data) {
    if (data == null) return Future.value();
    final Completer<dynamic> completer = Completer<dynamic>();
    callback[data.hashCode] = completer;

    debugPrint("yao main iso parseJson, iso name=${Isolate.current.debugName}");

    _outgoingSendPort.send(data);
    return completer.future;
  }

  Future<void> _createIsolate() async {
    debugPrint("yao main iso parseJson spawn start");
    _incomingReceivePort = ReceivePort();
    _isolate = await Isolate.spawn(
        _isolateWorker, _incomingReceivePort.sendPort,
        debugName: "jsonParser");
  }

  Future<void> _listen() async {
    _incomingReceivePort.listen((message) {
      debugPrint(
          "yao main isolate receive message type=${message.runtimeType}");
      if (message is SendPort) {
        _outgoingSendPort = message;
        debugPrint("yao main iso DataWorkerIsolat create success");
      } else if (message is IsoWorkResult) {
        final int code = message.code;
        final dynamic result = message.result;
        final Completer<dynamic> completer = callback[code];

        if (completer != null && !completer.isCompleted) {
          completer.complete(result);
        }
        callback.remove(code);
      }
    });
  }

  void dispose() {
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
  }
}
