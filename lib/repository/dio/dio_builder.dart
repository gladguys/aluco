import 'package:aluco/core/interceptor/loading_interceptor.dart';
import 'package:dio/dio.dart';

import 'package:aluco/repository/api/API.dart';
import '../../main.dart';
import 'dio_config.dart' as config;

class DioBuilder {
  factory DioBuilder() {
    return _singleton;
  }

  static final _singleton = DioBuilder();

  static final Dio _dio = Dio()
    ..options.baseUrl = API_URL
    ..interceptors.add(alice.getDioInterceptor())
    ..interceptors.add(LoadingInterceptor());

  static void setAuthorizationHeader() {
    getDio().options.headers = config.headers;
  }

  static Dio getDio() {
    return _dio;
  }
}
