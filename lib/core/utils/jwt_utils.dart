import 'pref_utils.dart';

class JWTUtils {
  static Future<void> storeInfo(Map<String, dynamic> loggedUserData) async {
    await PrefUtils.setToken(loggedUserData['token']);
    await PrefUtils.setTeacherId(loggedUserData['teacherId']);
    await PrefUtils.setUserId(loggedUserData['userId']);
    await PrefUtils.setUsername(loggedUserData['username']);
    await PrefUtils.setEmail(loggedUserData['email']);
    await PrefUtils.setName(loggedUserData['name']);
    await PrefUtils.setPhotoUrl(loggedUserData['photoUrl']);
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
}
