import 'package:aluco/utils/jwt_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final headers = <String, dynamic>{
  'Authorization': JWTUtils.getToken()
};

Function(RequestOptions) onRequest = (RequestOptions options) async {
  debugPrint('${options.method}: ${options.path}');
  debugPrint('Headers: ${options.headers}');
  debugPrint('Body: ${options.data}');
  return options;
};

Function(Response) onResponse = (Response response) async {
  debugPrint('Response: ${response.statusCode} \n - Payload: ${response.data}');
  return response;
};

Function(DioError) onError = (DioError error) async {
  debugPrint('******* ERROR ******* \n - Message: ${error.message}');
  return  error;
};