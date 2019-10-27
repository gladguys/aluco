import 'dart:convert';

import 'package:aluco/repository/api/API.dart';

import 'package:aluco/repository/core/abstract_auth_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';

class AuthRepository implements AbstractAuthRepository {
  final _dio = DioBuilder.getDio();

  @override
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

  @override
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