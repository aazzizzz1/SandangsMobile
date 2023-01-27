import 'package:sandangs/api/api_kategori.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/pages/detail_produk.dart';
import 'package:sandangs/widget/card/produk_card.dart';

import '../../models/produk_model.dart';

class GridViewKategoriProduk extends StatefulWidget {
  GridViewKategoriProduk({
    Key? key,
    required this.namaKategori,
  }): super(key: key);

  String namaKategori;

  @override
  State<GridViewKategoriProduk> createState() => _GridViewKategoriProdukState();
}

class _GridViewKategoriProdukState extends State<GridViewKategoriProduk> {
  late Future<Produk> _produk;

  @override
  void initState(){
    super.initState();
    print(widget.namaKategori);
    _produk = ApiServiceKategori(namaKategori: widget.namaKategori).topHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8, left: 8),
      child: FutureBuilder(
        future: _produk,
        builder: (context, AsyncSnapshot<Produk> snapshot){
          var state = snapshot.connectionState;
          if(state!=ConnectionState.done){
            return Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.hasData){
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.53,
                ),
                itemBuilder: (context, index) {
                  var produk = snapshot.data?.produk[index];
                  return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return DetailProduct(detail: produk!);
                            })
                        );
                      },
                      child: CardProduct(produk: produk!)
                  );
                },
                itemCount: snapshot.data?.produk.length,
              );
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }else{
              return Text('Tidak ada data');
            }
          }
        },
      ),
    );
  }
}