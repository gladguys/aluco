import 'package:aluco/core/locator/locator.dart';
import 'package:aluco/core/utils/jwt_utils.dart';
import 'package:aluco/core/utils/pref_utils.dart';
import 'package:aluco/repository/api/auth_repository.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

enum SigninState { idle, onGoing, succeeded, failed, wrongCredentials }

class SigninBloc extends BlocBase {
  final _repository = G<AuthRepository>();
  final signinStateController =
      BehaviorSubject<SigninState>.seeded(SigninState.idle);
  SigninState get signinState => signinStateController.value;

  Future<Map<String, dynamic>> tryToSigninUser(
      Map<dynamic, String> userData) async {
    try {
      signinStateController.add(SigninState.onGoing);
      final signinResult = await _repository.tryToSigninUser(userData);
      signinStateController.add(SigninState.succeeded);
      return signinResult;
    } catch (e) {
      if (e is DioError) {
        signinStateController.add(SigninState.wrongCredentials);
      } else {
        signinStateController.add(SigninState.failed);
      }
      throw Exception();
    }
  }

  Future<void> storeJWTInfo(Map<String, dynamic> loggedUserData) async {
    await JWTUtils.storeInfo(loggedUserData);
  }

  Future<void> markFirstLoginDone() async {
    await PrefUtils.setIsFirstLoginDone(true);
  }

  @override
  void dispose() {
    signinStateController.close();
    super.dispose();
  }
}
