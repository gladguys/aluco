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

  static Future<void> setEmail(String email) async {
    await preferences.setString('email', email);
  }

  static Future<void> setName(String name) async {
    await preferences.setString('name', name);
  }

  static Future<void> setPhotoUrl(String photoUrl) async {
    await preferences.setString('photoUrl', photoUrl);
  }

  static Future<void> setToken(String token) async {
    await preferences.setString('token', token);
  }

  static Future<void> setTeacherId(int teacherId) async {
    await preferences.setInt('teacherId', teacherId);
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
    return preferences.getInt('teacherId');
  }

  static String getEmail() {
    return preferences.getString('email');
  }

  static String getName() {
    return preferences.getString('name');
  }

  static String getPhotoUrl() {
    return preferences.getString('photoUrl');
  }

  static Future<void> clearToken() async {
    await setToken(null);
  }
}
