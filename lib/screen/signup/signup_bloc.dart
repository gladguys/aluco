import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/repository/api/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

enum SignupState { idle, onGoing, succeeded, failed, emailAlreadyTaken }

class SignUpBloc {
  final _repository = G<AuthRepository>();
  final signupStateController =
      BehaviorSubject<SignupState>.seeded(SignupState.idle);

  Future<void> signUpUser(Map<dynamic, String> userData) async {
    try {
      signupStateController.add(SignupState.onGoing);
      await _repository.signUpUser(userData);
      signupStateController.add(SignupState.succeeded);
    } catch (e) {
      if (e.response.statusCode == 422) {
        signupStateController.add(SignupState.emailAlreadyTaken);
      } else {
        signupStateController.add(SignupState.failed);
      }
      throw Exception();
    }
  }
}
