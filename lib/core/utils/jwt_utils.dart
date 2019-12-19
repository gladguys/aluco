import 'pref_utils.dart';

class JWTUtils {
  static Future<void> storeInfo(Map<String, dynamic> loggedUserData) async {
    await PrefUtils.setUserId(loggedUserData['userId']);
    await PrefUtils.setUsername(loggedUserData['username']);
    await PrefUtils.setToken(loggedUserData['token']);
  }

  static bool userAlreadySignedIn() {
    return getToken() != null;
  }

  static String getToken() {
    return PrefUtils.getToken();
  }

  static String getUsername() {
    return PrefUtils.getUsername();
  }

  static int getTeacherId() {
    return PrefUtils.getTeacherId();
  }

  static Future<void> clearInfo() async {
    await PrefUtils.setToken(null);
    await PrefUtils.setUsername(null);
    await PrefUtils.setUserId(null);
  }
}
