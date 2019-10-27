import 'package:dio/dio.dart';

import 'package:aluco/repository/api/API.dart';
import 'dio_config.dart' as config;

class DioBuilder {
  factory DioBuilder() {
    return _singleton;
  }

  static final _singleton = DioBuilder();

  static final Dio _dio = Dio()
    ..options.baseUrl = API_URL
    ..options.headers = config.headers
    ..interceptors.add(
      InterceptorsWrapper(
          onRequest: config.onRequest,
          onResponse: config.onResponse,
          onError: config.onError),
    );

  static Dio getDio() {
    return _dio;
  }
}
