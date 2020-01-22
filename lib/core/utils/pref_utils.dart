import '../../main.dart';

class PrefUtils {
  static Future<void> setIsFirstLoginDone(bool isFirstLoginDone) async {
    await preferences.setBool('isFirstLoginDone', isFirstLoginDone);
  }

  static Future<void> setUserId(int userId) async {
    await preferences.setInt('userId', userId);
  }

  static Future<void> setUsername(String username) async {
    print('username: $username');
    await preferences.setString('username', username);
    print('username: ${preferences.getString('username')}');
  }

  static Future<void> setEmail(String email) async {
    print('email: $email');
    await preferences.setString('email', email);
    print('email: ${preferences.getString('email')}');
  }

  static Future<void> setName(String name) async {
    print('name: $name');
    await preferences.setString('name', name);
    print('name: ${preferences.getString('name')}');
  }

  static Future<void> setPhotoUrl(String photoUrl) async {
    await preferences.setString('photoUrl', photoUrl);
  }

  static Future<void> setToken(String token) async {
    await preferences.setString('token', token);
  }

  static Future<void> setTeacherId(int teacherId) async {
    print('teacherId: $teacherId');
    await preferences.setInt('teacherId', teacherId);
    print('teacherId: ${preferences.getInt('teacherId')}');
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
}
