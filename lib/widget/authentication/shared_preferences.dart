import 'package:shared_preferences/shared_preferences.dart';

class PrefServices{
  Future createCache(List userData) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString("id", userData[0]);
    _preferences.setString("username", userData[1]);
    _preferences.setString("email", userData[2]);
    _preferences.setString("status", userData[3]);
  }

  Future <UserData> readCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    UserData _userData = UserData(
      id: _preferences.getString("id"),
      username: _preferences.getString("username"),
      email: _preferences.getString("email"),
      status: _preferences.getString("status"),
    );

    return _userData;
  }

  static Future removeCache(String username) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("username");
    _preferences.remove("email");
    _preferences.remove("status");
  }


}

class UserData{
  final String? id;
  final String? username;
  final String? email;
  final String? status;

  UserData({
    required this.id,
    required this.username,
    required this.email,
    required this.status,
  });
}