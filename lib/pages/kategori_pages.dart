import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/pages/cart_screen.dart';
import 'package:sandangs/widget/provider/cart_provider.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';
import 'package:sandangs/widget/gridview/gridview_kategori_produk.dart';

class KategoriPage extends StatefulWidget {
  String namaKategori;
  KategoriPage({
    required this.namaKategori,
  });

  @override
  State<KategoriPage> createState() => _KategoriPageState(namaKategori: namaKategori);
}

class _KategoriPageState extends State<KategoriPage> {
  String namaKategori;

  _KategoriPageState({
    required this.namaKategori,
  });

  @override
  Widget build(BuildContext context) {
    var keranjang = Provider.of<KeranjangProv>(context, listen: true);
    keranjang.jumlahplus();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: secondaryColor,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text(
          "$namaKategori",
          style: tittleDark,
        ),
        actions: [
          Center(
            child: keranjang.jumlah > 0 ? Badge(
              badgeColor: Colors.orange,
              animationType: BadgeAnimationType.slide,
              borderSide: BorderSide(color: Colors.white),
              badgeContent: Text(
                keranjang.jumlah.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              position: BadgePosition.topEnd(top: 0, end: 5),
              child: IconButton(
                icon  : Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: secondaryColor,
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartScreen()
                    ),
                  );
                },
              ),
            ) : IconButton(
              icon  : Icon(
                Icons.shopping_cart,
                size: 25,
                color: secondaryColor,
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen()
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 10
                ),
              ),
              GridViewKategoriProduk(namaKategori: namaKategori),
            ],
          )),
      );
  }
}
