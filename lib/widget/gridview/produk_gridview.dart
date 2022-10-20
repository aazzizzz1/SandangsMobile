import 'package:flutter/material.dart';
import 'package:sandangs/api/api_produk.dart';
import 'package:sandangs/models/produk_model.dart';
import 'package:sandangs/pages/detail_produk.dart';
import 'package:sandangs/widget/card/produk_card.dart';

class ProdukGridview extends StatefulWidget {
  const ProdukGridview({Key? key}) : super(key: key);

  @override
  State<ProdukGridview> createState() => _ProdukGridviewState();
}

class _ProdukGridviewState extends State<ProdukGridview> {
  late Future<Produk> produkApi;

  @override
  void initState() {
    super.initState();
    produkApi = ApiServiceProduct().topHeadLines();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8, left: 8),
      child: FutureBuilder(
        future: produkApi,
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
                      onTap: () async{
                        await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return DetailProduct(detail: produk!);
                            })
                        );
                      },
                      child: CardProduct(produk: produk!),
                  );
                },
                itemCount: snapshot.data?.produk.length,
              );
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }else{
              return Text('');
            }
          }
        },
      ),
    );
  }
}
