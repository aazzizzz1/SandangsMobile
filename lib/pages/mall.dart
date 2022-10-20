import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/widget/gridview/produk_gridview.dart';
import 'package:sandangs/widget/kategori/kategori_produk.dart';
import 'package:sandangs/widget/slideview/slideview.dart';

class Mall extends StatefulWidget {

  const Mall({Key? key}) : super(key: key);

  @override
  State<Mall> createState() => _MallState();
}

class _MallState extends State<Mall> {

  @override
  Widget build(BuildContext context) {
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
          "Sandangs Mall",
          style: tittleDark,
        ),
        actions: [
          Center(
            child: IconButton(
              icon  : Icon(
                Icons.shopping_cart,
                size: 25,
                color: secondaryColor,
              ),
              onPressed: (){},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SlideView(),
              Container(
                margin: EdgeInsets.only(top: 10),
              ),
              KategoriProduk(),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25, top: 10),
                child: Row(
                  children: [
                    Text('Recommended',
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        )),
                    Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: Text('View All',
                          style: TextStyle(
                            color: secondaryColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                          )),
                    ),
                  ],
                ),
              ),
              ProdukGridview(),
            ],
          )),
    );
  }
}
