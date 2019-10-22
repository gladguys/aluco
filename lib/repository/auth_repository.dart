import 'dart:convert';

import 'package:aluco/repository/API.dart';

import 'dio/dio_builder.dart';

class AuthRepository {
  final _dio = DioBuilder.getDio();

  Future<Map<String, dynamic>> tryToSigninUser(Map<dynamic, String> userData) async {
    try {
      final response = await _dio.post<dynamic>('$API_URL/$AUTH', data: jsonEncode(userData));
      return <String, dynamic>{
        'token': response.data['token'],
        'userId': response.data['user']['id']
      };
    } catch(e) {
      return null;
    }
  }
}