import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:discord_ui_clone/utils/data_worker_lsolate.dart';
import 'package:discord_ui_clone/utils/github_repo.dart';
import 'package:discord_ui_clone/widgets/guild/model/github_user_bean.dart';
import 'package:flutter/foundation.dart';

// Must be top-level function
dynamic _parseAndDecode(String response) {
  return jsonDecode(response);
}

dynamic parseJson(String text) {
  return compute(_parseAndDecode, text);
}

class HttpClient {
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

  static const String host = "https://api.github.com";
  static const String repos = "/orgs/flutterchina/repos";

  static const String users = "/users";

  static final HttpClient _singleton = HttpClient._internal();

  Dio _dio;

  Future<List<GithubRepo>> getGitHub1() async {
    final start = DateTime.now();

    (_dio.transformer as DefaultTransformer).jsonDecodeCallback =
        parseJsonForHttp;

    final response = await _dio.get(repos);
    final data = response.data as List;
    final List<GithubRepo> list =
        data.map((e) => GithubRepo.fromJson(e)).toList();

    final used = DateTime.now().difference(start).inMilliseconds;

    debugPrint("yao used compute time=$used");

    return Future.value(list);
  }

  Future<List<GithubRepo>> getGitHub2() async {
    final start = DateTime.now();
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback = null;

    final response = await _dio.get(repos);
    final data = response.data as List;
    final List<GithubRepo> list =
        data.map((e) => GithubRepo.fromJson(e)).toList();
    final used = DateTime.now().difference(start).inMilliseconds;

    debugPrint("yao used main time=$used");
    return Future.value(list);
  }

  Future<List<Githubuserbean>> getGitHubUser() async {
    final start = DateTime.now();
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback =
        parseJsonForHttp;
    try {
      final response = await _dio.get(users);
      final data = response.data as List;
      final List<Githubuserbean> list =
          data.map((e) => Githubuserbean.fromMap(e)).toList();
      final used = DateTime.now().difference(start).inMilliseconds;

      debugPrint("yao used main time=$used");
      return Future.value(list);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<String>> getGitHubUserGrid() async {
    final start = DateTime.now();
    (_dio.transformer as DefaultTransformer).jsonDecodeCallback =
        parseJsonForHttp;
    try {
      final response = await _dio.get(users);
      final data = response.data as List;
      final List<Githubuserbean> list =
          data.map((e) => Githubuserbean.fromMap(e)).toList();
      final used = DateTime.now().difference(start).inMilliseconds;

      debugPrint("yao used main time=$used");

      final List<String> res = list.map((e) => e.avatarUrl).toList();

      return Future.value(res);
    } catch (e) {
      print(e);
      return null;
    }
  }
}
