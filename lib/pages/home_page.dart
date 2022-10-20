import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/widget/appbar_custom/appbar.dart';
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldpop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            title: const Text('Exit App'),
            content: const Text('Are you sure to exit the app?'),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: ()=>SystemNavigator.pop(),
                child: Text(
                  'Yes',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: ()=>Navigator.pop(context,false),
                child: Text(
                  'No',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        );
        return shouldpop!;
      },
      child: Scaffold(
        appBar: const AppBarApps(),
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
      ),
    );
  }
}
