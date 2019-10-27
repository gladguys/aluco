import '../main.dart';

class JWTUtils {

  static Future<void> storeInfo(Map<String, dynamic> loggedUserData) async {
    await preferences.setInt('userId', loggedUserData['userId']);
    await preferences.setString('token', loggedUserData['token']);
  }

  static String getToken() {
    return preferences.getString('token');
  }

  static int getTeacherId() {
    return preferences.getInt('userId');
  }
}