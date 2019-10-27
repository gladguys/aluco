abstract class AbstractAuthRepository {
  Future<Map<String, dynamic>> tryToSigninUser(Map<dynamic, String> userData);
  Future<void> signUpUser(Map<dynamic, String> userData);
}