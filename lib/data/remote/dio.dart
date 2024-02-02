// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_collection_literals

import 'package:dio/dio.dart';
import '/data/local/secure/secure_storage_manager.dart';
import 'log_interceptor.dart';

class AppDio {
  Future<Dio> getBasicDIO({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    var dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        contentType: "application/json"
      )
    );

    //dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(APILogInterceptor());
    
    return dio;
  }

  Future<Dio> getDIO({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final _headers = Map<String, dynamic>.from(headers);
    final token = await SecureStorageManager().getToken() ?? "";
    if (!_headers.containsKey("Authorization") && token.isNotEmpty) {
      _headers["Authorization"] = "Bearer $token";
    }
    var dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        contentType: "application/json"
      )
    );

    final defaultHeaders = Map<String, dynamic>();

    // override headers if needed
    defaultHeaders.addAll(headers);

    // apply new headers
    dio.options.headers.addAll(_headers);

    //dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(APILogInterceptor());
    
    return dio;
  }

  Future<Dio> getDIOFile({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final _headers = Map<String, dynamic>.from(headers);
    final token = await SecureStorageManager().getToken() ?? "";
    if (!_headers.containsKey("Authorization") && token.isNotEmpty) {
      _headers["Authorization"] = "Bearer $token";
    }
    var dio = Dio(
      BaseOptions(
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
        contentType: 'multipart/form-data; boundary=kyaaNakaWaZettaiDame',
      )
    );

    final defaultHeaders = Map<String, dynamic>();

    // override headers if needed
    defaultHeaders.addAll(headers);

    // apply new headers
    dio.options.headers.addAll(_headers);

    //dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(APILogInterceptor());
    
    return dio;
  }

  Future<Dio> getDIODownload({
    Map<String, dynamic> headers = const {},
    int connectTimeout = 30000,
    int receiveTimeout = 30000,
  }) async {
    final _headers = Map<String, dynamic>.from(headers);
    final token = await SecureStorageManager().getToken() ?? "";
    if (!_headers.containsKey("Authorization") && token.isNotEmpty) {
      _headers["Authorization"] = "Bearer $token";
    }
    var dio = Dio(
      BaseOptions(
        responseType: ResponseType.bytes,
        followRedirects: false,
        connectTimeout: connectTimeout,
        receiveTimeout: receiveTimeout,
      )
    );

    final defaultHeaders = Map<String, dynamic>();

    // override headers if needed
    defaultHeaders.addAll(headers);

    // apply new headers
    dio.options.headers.addAll(_headers);

    //dio.interceptors.add(LogInterceptor(responseBody: true));
    dio.interceptors.add(APILogInterceptor());
    
    return dio;
  }
}