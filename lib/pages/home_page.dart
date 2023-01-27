import 'package:flutter/material.dart';
import 'package:sandangs/models/user_model.dart';
import 'package:sandangs/variables.dart';
import 'package:sandangs/widget/appbar_custom/appbar.dart';
import 'package:sandangs/widget/db_helper/db_user.dart';
import 'package:sandangs/widget/gridview/produk_gridview.dart';
import 'package:sandangs/widget/listview/desainer_listview.dart';
import 'package:sandangs/widget/listview/konveksi_listview.dart';
import 'package:sandangs/widget/main_button/main_button.dart';
import 'package:sandangs/widget/slideview/slideview.dart';
import 'package:sandangs/widget/tittle/sub_tittle.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<UserList> listUser = [];
  DbHelperUser db = DbHelperUser();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApps(),
      body: ListView(
        children: const [
          SlideView(),
          MainButton(),
          SubTittle(sub: "Top Desainer"),
          DesainerListview(),
          SubTittle(sub: "Top Konveksi"),
          KonveksiListview(),
          SubTittle(sub: "Rekomendasi Produk"),
          ProdukGridview(),
        ],
      ),
    );

  }
  Future<void> _getUser() async{
    var list = await db.getUser();
    listUser.clear();
    setState(() {
      list!.forEach((user) {
        listUser.add(UserList.fromMap(user));
      });
      idUserGlob = listUser[0].idUser;
    });
  }
}