import 'package:http/http.dart' as http;
import 'package:sandangs/models/user_model.dart';
import 'dart:convert';
import 'package:sandangs/widget/db_helper/db_user.dart';

class ApiServiceGetUser{
  DbHelperUser dbu = DbHelperUser();
  List<UserList> listUser = [];

  Future<List> topHeadLines({required String email}) async {
    final response = await http.post(Uri.parse("https://fashionizt.yufagency.com/get_user.php"), body: {
      "email": email,
    });
    var datauser = json.decode(response.body);
    List user = datauser.split(' ');
    await dbu.saveUser(UserList(
      idUser: user[0],
      username: user[1],
      email: user[2],
      level: user[3],
    ));

    return user;
  }
}
