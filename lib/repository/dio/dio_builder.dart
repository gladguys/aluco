import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';

import 'package:aluco/repository/api/API.dart';
import '../../main.dart';
import '../../test_bloc.dart';
import 'dio_config.dart' as config;

class DioBuilder {
  factory DioBuilder() {
    return _singleton;
  }

  static final _singleton = DioBuilder();

  static final Dio _dio = Dio()
    ..options.baseUrl = API_URL
    ..interceptors.add(
      alice.getDioInterceptor(),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options) => BlocProvider.getBloc<TestBloc>().loadingController.add(true),
        onResponse: (response) => BlocProvider.getBloc<TestBloc>().loadingController.add(false),
        onError: (error) => BlocProvider.getBloc<TestBloc>().loadingController.add(false),
      )
    );

  static void setAuthorizationHeader() {
    getDio().options.headers = config.headers;
  }

  static Dio getDio() {
    return _dio;
  }
}
