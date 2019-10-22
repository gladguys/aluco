import 'dart:convert';

import 'package:aluco/repository/API.dart';

import 'dio_builder.dart';

class AuthRepository {
  final _dio = DioBuilder.getDio();

  Future<bool> tryToSigninUser(Map<dynamic, String> userData) async {
    try {
      final response = await _dio.post<dynamic>('$API_URL/$AUTH', data: jsonEncode(userData));
      print(response);
      return true;
    } catch(e) {
      rethrow;
    }
  }
}