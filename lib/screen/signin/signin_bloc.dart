import 'package:aluco/repository/auth_repository.dart';

class SigninBloc {
  final _repository = AuthRepository();

  Future<bool> tryToSigninUser(Map<dynamic, String> userData) async {
    try {
      return await _repository.tryToSigninUser(userData);
    } catch(e) {
      throw Exception();
    }
  }
}