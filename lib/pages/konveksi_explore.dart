import 'package:flutter/material.dart';
import 'package:sandangs/api/api_top_konveksi.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/konveksi_model.dart';
import 'package:sandangs/pages/pilih_konveksi.dart';
import 'package:sandangs/widget/kategori/kategori_produk.dart';
import 'package:sandangs/widget/listview/vertical_list_konveksi.dart';
import 'package:sandangs/pages/cart_screen.dart';
import 'package:sandangs/widget/provider/cart_provider.dart';
import 'package:badges/badges.dart';
import 'package:provider/provider.dart';

class KonveksiExplore extends StatefulWidget {
  const KonveksiExplore({Key? key}) : super(key: key);

  @override
  State<KonveksiExplore> createState() => _KonveksiExploreState();
}

class _KonveksiExploreState extends State<KonveksiExplore> {
  var keranjang;
  var state;
  var konveksi;
  var list;

  @override
  late Future<Konveksi> allKonveksiApi;

  @override
  void initState(){
    super.initState();
    allKonveksiApi = ApiServiceTopKonveksi().topHeadLines();
  }

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
          "Explore Konveksi",
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
              const KategoriProduk(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Recommended',
                            style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            )
                        ),
                        Spacer(),
                        TextButton(
                          style: TextButton.styleFrom(),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PilihKonveksi())
                            );
                          },
                          child: Text(
                              'View All',
                              style: TextStyle(
                                color: secondaryColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                              )),
                        ),
                      ],
                    ),
                    Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          FutureBuilder(
                            future: allKonveksiApi,
                            builder: (context, AsyncSnapshot<Konveksi> snapshot) {
                              state = snapshot.connectionState;
                              if (state != ConnectionState.done) {
                                return Center(child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data?.konveksi.length,
                                    itemBuilder: (context, index) {
                                      konveksi = snapshot.data?.konveksi[index];
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) {
                                                  return Scaffold();
                                                }));
                                          },
                                          child: VerticalListKonveksi(konveksi: konveksi!,)
                                      );
                                    },
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(child: Text(snapshot.error.toString()));
                                } else {
                                  return Text('');
                                }
                              }
                            },
                          )
                        ]
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}