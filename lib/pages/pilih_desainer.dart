import 'package:flutter/material.dart';
import 'package:sandangs/api/api_all_desainer.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/desainer_model.dart';
import 'package:sandangs/pages/detail_desainer.dart';
import 'package:sandangs/widget/listview/vertical_list_desainer.dart';


class PilihDesainer extends StatefulWidget {
  Pilih createState() => Pilih();
}

class Pilih extends State<PilihDesainer> {
  late Future<Desainer> desainerApi;

  @override
  void initState() {
    super.initState();
    desainerApi = ApiServiceDesainer().topHeadLines();
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
                            future: desainerApi,
                            builder: (context, AsyncSnapshot<Desainer> snapshot) {
                              var state = snapshot.connectionState;
                              if (state != ConnectionState.done) {
                                return Center(child: CircularProgressIndicator());
                              } else {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data?.desainer.length,
                                    itemBuilder: (context, index) {
                                      var desainer = snapshot.data?.desainer[index];
                                      return InkWell(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) {
                                                  return DetailDesainer(desainer: desainer!);
                                                }));
                                          },
                                          child: VerticalListDesainer(desainer: desainer!)
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
        title: Text('Our Desainer',
          style: tittleLight,
        ),
        backgroundColor: secondaryColor,
      ),
      body: _buildList(context),
    );
  }
}