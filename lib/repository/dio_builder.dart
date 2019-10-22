import 'package:dio/dio.dart';

class DioBuilder {
  factory DioBuilder() {
    return _singleton;
  }

  static final _singleton = DioBuilder();

  static final Dio _dio = Dio()
    ..interceptors.add(InterceptorsWrapper(
        onRequest:(RequestOptions options) async {
          print('${options.method}: ${options.path}');
          return options;
        },
        onResponse:(Response response) async {
          print('SERVER RESPONSE: ${response.statusCode} \n - Payload: ${response.data}');
          return response;
        },
        onError: (DioError e) async {
          print('******* ERROR ******* \n - Message: ${e.message}');
          return  e;
        }
    ));

  static Dio getDio() {
    return _dio;
  }
}