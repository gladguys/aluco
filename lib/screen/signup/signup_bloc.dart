import 'package:aluco/repository/api/auth_repository.dart';

class SignUpBloc {
  final _repository = AuthRepository();

  Future<void> signUpUser(Map<dynamic, String> userData) async {
    try {
      await _repository.signUpUser(userData);
    } catch(e) {
      throw Exception();
    }
  }
}