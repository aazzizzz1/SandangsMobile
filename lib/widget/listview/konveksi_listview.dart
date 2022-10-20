import 'package:flutter/material.dart';
import 'package:sandangs/api/api_top_konveksi.dart';
import 'package:sandangs/models/konveksi_model.dart';
import 'package:sandangs/pages/detail_konveksi.dart';
import 'package:sandangs/pages/profil_desainer.dart';
import 'package:sandangs/widget/card/konveksi_card.dart';

class KonveksiListview extends StatefulWidget {
  const KonveksiListview({Key? key}) : super(key: key);

  @override
  State<KonveksiListview> createState() => _KonveksiListviewState();
}

class _KonveksiListviewState extends State<KonveksiListview> {
  late Future<Konveksi> konveksiApi;

  @override
  void initState(){
    super.initState();
    konveksiApi = ApiServiceTopKonveksi().topHeadLines();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      padding: const EdgeInsets.only(left: 10),
      child: FutureBuilder(
        future: konveksiApi,
        builder: (context, AsyncSnapshot<Konveksi> snapshot){
          var state = snapshot.connectionState;
          if(state != ConnectionState.done){
            return const Center(child: CircularProgressIndicator());
          }else{
            if(snapshot.hasData){
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  var konveksi = snapshot.data?.konveksi[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(
                          (context),
                          MaterialPageRoute(builder: (context) => DetailKonveksi(konveksi: konveksi!))
                      );
                    },
                    child: CardKonveksi(konveksi: konveksi!),
                  );
                },
                itemCount: snapshot.data?.konveksi.length,
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
