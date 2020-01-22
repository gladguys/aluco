import 'package:aluco/core/utils/pref_utils.dart';
import 'package:aluco/screen/signin/signin_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TokenExpiredInterceptor implements InterceptorsWrapper {
  @override
  Future onError(DioError err) async {
    if (err.response.statusCode == 401) {
      await PrefUtils.clearToken();
      Get.offAll(SigninScreen(), (v) => false);
      Get.defaultDialog(
        content: const Text('Sua sessão expirou. Faça login novamente'),
        title: 'Sessão Expirada',
        confirm: RaisedButton(
          onPressed: () => Get.back(),
          color: Colors.orange[600],
          child: const Text('OK'),
        ),
      );
    }
  }

  @override
  Future onRequest(RequestOptions options) async {}

  @override
  Future onResponse(Response response) async {}
}
