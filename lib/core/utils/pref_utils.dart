import '../../main.dart';

class PrefUtils {
  static Future<void> setIsFirstLoginDone(bool isFirstLoginDone) async {
    await preferences.setBool('isFirstLoginDone', isFirstLoginDone);
  }

  static Future<void> setUserId(int userId) async {
    await preferences.setInt('userId', userId);
  }

  static Future<void> setUsername(String username) async {
    await preferences.setString('username', username);
  }

  static Future<void> setToken(String token) async {
    await preferences.setString('token', token);
  }

  static bool isFirstLoginDone() {
    return _getIsFirstLoginDone();
  }

  static bool _getIsFirstLoginDone() {
    return preferences.getBool('isFirstLoginDone') ?? false;
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
}
