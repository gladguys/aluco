import 'package:aluco/utils/jwt_utils.dart';
import 'package:dio/dio.dart';

final headers = <String, dynamic>{
  'token': JWTUtils.getToken()
};

Function(RequestOptions) onRequest = (RequestOptions options) async {
  print('${options.method}: ${options.path}');
  print('Headers: ${options.headers}');
  return options;
};

Function(Response) onResponse = (Response response) async {
  print('Response: ${response.statusCode} \n - Payload: ${response.data}');
  return response;
};

Function(DioError) onError = (DioError error) async {
  print('******* ERROR ******* \n - Message: ${error.message}');
  return  error;
};