import 'package:aluco/repository/auth_repository.dart';
import 'package:aluco/repository/dio/dio_builder.dart';
import 'package:aluco/utils/jwt_utils.dart';

class SigninBloc {
  final _repository = AuthRepository();

  Future<Map<String, dynamic>> tryToSigninUser(Map<dynamic, String> userData) async {
    try {
      return await _repository.tryToSigninUser(userData);
    } catch(e) {
      throw Exception();
    }
  }

  Future<void> storeJWTInfo(Map<String, dynamic> loggedUserData) async {
    await JWTUtils.storeInfo(loggedUserData);
  }

  void setAuthorizationHeader() {
    DioBuilder.setAuthorizationHeader();
  }
}