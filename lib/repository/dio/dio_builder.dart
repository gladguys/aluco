import 'package:aluco/core/interceptor/loading_interceptor.dart';
import 'package:aluco/core/interceptor/token_expired_interceptor.dart';
import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/repository/api/API.dart';
import 'package:dio/dio.dart';

import '../../main.dart';

class DioBuilder {
  static Dio getDio({bool isMultipartFile = false}) {
    return Dio()
      ..options.baseUrl = API_URL
      ..options.headers = <String, dynamic>{
        'Authorization': JWTUtils.getToken(),
        'Content-Type':
            isMultipartFile ? 'multipart/form-data' : 'application/json'
      }
      ..interceptors.add(alice.getDioInterceptor())
      ..interceptors.add(LoadingInterceptor())
      ..interceptors.add(TokenExpiredInterceptor());
  }
}
