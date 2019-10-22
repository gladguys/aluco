import 'package:dio/dio.dart';

import 'dio_config.dart' as config;

class DioBuilder {
  factory DioBuilder() {
    return _singleton;
  }

  static final _singleton = DioBuilder();

  static final Dio _dio = Dio()
    // TODO(rodrigo): replace for the api when more stable
    //..options.baseUrl = ''
    ..options.headers = config.headers
    ..interceptors.add(InterceptorsWrapper(
        onRequest: config.onRequest,
        onResponse: config.onResponse,
        onError: config.onError
    ));

  static Dio getDio() {
    return _dio;
  }
}