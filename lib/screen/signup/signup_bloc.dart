import 'package:aluco/repository/api/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

enum SignupState { idle, onGoing, succeeded, failed, emailAlreadyTaken }

class SignUpBloc {
  final _repository = AuthRepository();
  final signupStateController = BehaviorSubject<SignupState>.seeded(SignupState.idle);

  Future<void> signUpUser(Map<dynamic, String> userData) async {
    try {
      signupStateController.add(SignupState.onGoing);
      await _repository.signUpUser(userData);
      signupStateController.add(SignupState.succeeded);
    } catch(e) {
      print(e);
      if (e is DioError) {
        signupStateController.add(SignupState.emailAlreadyTaken);
      } else {
        signupStateController.add(SignupState.failed);
      }
      throw Exception();
    }
  }
}