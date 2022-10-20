import 'package:flutter/material.dart';
import 'package:sandangs/api/api_top_desainer.dart';
import 'package:sandangs/models/desainer_model.dart';
import 'package:sandangs/pages/detail_desainer.dart';
import 'package:sandangs/widget/card/desainer_card.dart';

class DesainerListview extends StatefulWidget {
  const DesainerListview({Key? key}) : super(key: key);

  @override
  State<DesainerListview> createState() => _DesainerListviewState();
}

class _DesainerListviewState extends State<DesainerListview> {
  late Future<Desainer> desainerApi;

  @override
  void initState(){
    super.initState();
    desainerApi = ApiServiceTopDesainer().topHeadLines();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.only(left: 10),
      // padding: const EdgeInsets.only(left: 10),
      child: FutureBuilder(
        future: desainerApi,
        builder: (context, AsyncSnapshot<Desainer> snapshot){
          var state = snapshot.connectionState;
          if(state != ConnectionState.done){
            return const Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.hasData){
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  var desainer = snapshot.data?.desainer[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                        (context),
                        MaterialPageRoute(builder: (context) => DetailDesainer(desainer: desainer!))
                      );
                    },
                    child: CardDesainer(desainer: desainer!),
                  );
                },
                itemCount: snapshot.data?.desainer.length,
              );
            } else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Text('');
            }
          }
        },
      ),
    );
  }
}
