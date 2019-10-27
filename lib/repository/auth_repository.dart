import 'dart:convert';

import 'package:aluco/repository/API.dart';

import 'dio/dio_builder.dart';

class AuthRepository {
  final _dio = DioBuilder.getDio();

  Future<Map<String, dynamic>> tryToSigninUser(Map<dynamic, String> userData) async {
    try {
      final response = await _dio.post<dynamic>(AUTH, data: jsonEncode(userData));
      return <String, dynamic>{
        'token': response.data['token'],
        'userId': response.data['user']['id']
      };
    } catch(e) {
      return null;
    }
  }

  Future<void> signUpUser(Map<dynamic, String> userData) async {
    print(userData);
    try {
      await _dio.post<dynamic>(TEACHER, data: jsonEncode(userData));
      return <String, dynamic>{
        'email': userData['email'],
        'password': userData['password']
      };
    } catch(e) {
      rethrow;
    }
  }
}