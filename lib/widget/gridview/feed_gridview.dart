import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/api/api_produk.dart';
import 'package:sandangs/models/produk_model.dart';
import 'package:sandangs/pages/detail_produk.dart';
import 'package:sandangs/widget/card/feed_card.dart';

class GridViewFeeds extends StatefulWidget {
  const GridViewFeeds({Key? key}) : super(key: key);

  @override
  State<GridViewFeeds> createState() => _GridViewFeedsState();
}

class _GridViewFeedsState extends State<GridViewFeeds> {
  late Future<Produk> feedsApi;

  @override
  void initState(){
    super.initState();
    feedsApi = ApiServiceProduct().topHeadLines();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 1),
      child: FutureBuilder(
        future: feedsApi,
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
                  crossAxisCount: 3,
                  childAspectRatio: 1/1.55,
                ),
                itemBuilder: (context, index) {
                  var feeds = snapshot.data?.produk[index];
                  return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return DetailProduct(detail: feeds!);
                            })
                        );
                      },
                      child: FeedsCard(produk: feeds!)
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