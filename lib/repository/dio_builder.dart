import 'package:dio/dio.dart';

class DioBuilder {
  factory DioBuilder() {
    return _singleton;
  }

  static final _singleton = DioBuilder();

  static final Dio _dio = Dio();

  static Dio getDio() {
    return _dio;
  }
}