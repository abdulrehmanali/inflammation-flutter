import 'package:anti_inflammatory_app/Model/loginusermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static const String uidKey = 'uid';
  static const String nameKey = 'name';
  static const String emailKey = 'email';
  static const String tokenKey = 'token';

  static Future<void> setUserF(
      {String uid = "",
      String name = "",
      String email = "",
      String token = ""}) async {
    await SharedPreferences.getInstance().then((prefs) {
      if (uid.isNotEmpty) {
        prefs.setString(uidKey, uid);
      }
      if (name.isNotEmpty) {
        prefs.setString(nameKey, name);
      }
      if (email.isNotEmpty) {
        prefs.setString(emailKey, email);
      }
      if (token.isNotEmpty) {
        prefs.setString(tokenKey, token);
      }
    });
  }

  static Future<LoginUserModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(uidKey).toString();
    final name = prefs.getString(nameKey).toString();
    final email = prefs.getString(emailKey).toString();
    final token = prefs.getString(tokenKey).toString();

    return LoginUserModel(id: id, name: name, email: email, token: token);
  }

  static clear() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
