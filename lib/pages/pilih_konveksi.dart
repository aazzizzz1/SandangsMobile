import 'package:flutter/material.dart';
import 'package:sandangs/api/api_all_konveksi.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/konveksi_model.dart';
import 'package:sandangs/widget/listview/vertical_list_konveksi.dart';


class PilihKonveksi extends StatefulWidget {
  Pilih createState() => Pilih();
}

class Pilih extends State<PilihKonveksi> {
  late Future<Konveksi> konveksiApi;

  @override
  void initState() {
    super.initState();
    konveksiApi = ApiServiceKonveksi().topHeadLines();
  }

  @override
  Widget  _buildList(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FutureBuilder(
                              future: konveksiApi,
                              builder: (context, AsyncSnapshot<Konveksi> snapshot) {
                                var state = snapshot.connectionState;
                                if (state != ConnectionState.done) {
                                  return Center(child: CircularProgressIndicator());
                                } else {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data?.konveksi.length,
                                      itemBuilder: (context, index) {
                                        var konveksi = snapshot.data?.konveksi[index];
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
              ]
          )
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: Text('Our Konveksi',
          style: tittleLight,
        ),
        backgroundColor: secondaryColor,
      ),
      body: _buildList(context),
    );
  }
}