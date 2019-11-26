import '../../main.dart';

class JWTUtils {

  static Future<void> storeInfo(Map<String, dynamic> loggedUserData) async {
    await preferences.setInt('userId', loggedUserData['userId']);
    await preferences.setString('token', loggedUserData['token']);
    await preferences.setString('username', loggedUserData['username']);
  }

  static String getToken() {
    return preferences.getString('token');
  }

  static String getUsername() {
    return preferences.getString('username');
  }

  static int getTeacherId() {
    return preferences.getInt('userId');
  }

  static Future<void> clearUserInfo() async {
    await preferences.clear();
  }
}