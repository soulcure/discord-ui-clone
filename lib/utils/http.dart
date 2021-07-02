import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:discord_ui_clone/utils/github_repo.dart';
import 'package:flutter/foundation.dart';

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class HttpClient {
  static final HttpClient _singleton = HttpClient._internal();

  static const String host = "https://api.github.com";
  static const String repos = "/orgs/flutterchina/repos";

  Dio _dio;

  factory HttpClient() {
    return _singleton;
  }
  HttpClient._internal() {
    _dio = Dio();
    _dio.interceptors.add(LogInterceptor());

    _dio.options.baseUrl = host;
    _dio.options
      ..responseType = ResponseType.json
      ..sendTimeout = 5000
      ..receiveTimeout = 5000
      ..connectTimeout = 5000; //连接超时改为5秒
  }

  Future<List<GithubRepo>> getGitHub1() async {
    final start = DateTime.now();

    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    var response = await _dio.get(repos);
    final data = response.data as List;
    List<GithubRepo> list = data.map((e) => GithubRepo.fromJson(e)).toList();

    final used = DateTime.now().difference(start).inMilliseconds;

    debugPrint("yao used compute time=$used");

    return Future.value(list);
  }

  Future<List<GithubRepo>> getGitHub2() async {
    final start = DateTime.now();
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = null;

    var response = await _dio.get(repos);
    final data = response.data as List;
    List<GithubRepo> list = data.map((e) => GithubRepo.fromJson(e)).toList();
    final used = DateTime.now().difference(start).inMilliseconds;

    debugPrint("yao used main time=$used");
    return Future.value(list);
  }
}
