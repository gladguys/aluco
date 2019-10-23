import '../main.dart';

class JWTUtils {

  static Future<void> storeInfo(Map<String, dynamic> loggedUserData) async {
    preferences.setInt('userId', loggedUserData['userId']);
    preferences.setString('token', loggedUserData['token']);
  }

  static String getToken() {
    return preferences.getString('token');
  }

  static int getTeacherId() {
    return preferences.getInt('userId');
  }

  // TODO(rodrigo): do this logic
  static Future<bool> isTokenValid() async {
    return true;
  }

  // TODO(rodrigo): do this logic
  static Future<bool> isTokenExpired() async {
    return true;
  }
}