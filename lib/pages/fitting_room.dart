import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandangs/api/api_kategori.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/produk_model.dart';
import 'package:sandangs/widget/appbar_custom/appbar.dart';
import 'package:sandangs/widget/fitting/list_kategori.dart';
import 'package:sandangs/widget/provider/fitting_room_provider.dart';

class FittingRoom extends StatefulWidget {
  const FittingRoom({Key? key}) : super(key: key);

  @override
  State<FittingRoom> createState() => _FittingRoomState();
}

class _FittingRoomState extends State<FittingRoom> {
  int click = 0;
  int swap = 0;
  int index = 0;
  int status = 0;
  int checkAtasan = 0;
  int checkBawahan = 0;
  late Future<Produk> produkApi;

  @override
  void initState(){
    super.initState();
    produkApi = ApiServiceKategori(namaKategori: kategoriList[index].name).topHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var fittingRoom = Provider.of<FittingRoomProv>(context, listen: true);
    String busanaAtasan = "";
    String busanaBawahan = "";

    setState(() {
      busanaAtasan = fittingRoom.getAtasan();
      busanaBawahan = fittingRoom.getBawahan();
      swap = fittingRoom.getSwap();
      status = fittingRoom.getStatus();
      if(status == 0){
        index = checkAtasan;
        fittingRoom.setIndexKategori(index);
        produkApi = ApiServiceKategori(namaKategori: kategoriList[index].name).topHeadlines();
      }else{
        index = checkBawahan+3;
        fittingRoom.setIndexKategori(index);
        produkApi = ApiServiceKategori(namaKategori: kategoriList[index].name).topHeadlines();
      }
    });

    return Scaffold(
      appBar: AppBarApps(),
      body: ListView(
            children: <Widget>[
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                      height: size.height * 0.5,
                      width: size.width,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: secondaryColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: swap == 0 ? Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height*0.4,
                            margin: EdgeInsets.only(top: size.height*0.15, left: size.width*0.1),
                            child: InteractiveViewer(
                              boundaryMargin: EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                              minScale: 0.1,
                              maxScale: 1.5,
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: busanaBawahan == 'lib/assets/images/iconBawahan.png' ?
                                       Image.asset('lib/assets/images/jeans.png')
                                       : Image.network(busanaBawahan,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: size.height*0.3,
                            margin: EdgeInsets.only(left: size.width*0.1),
                            child: InteractiveViewer(
                              boundaryMargin: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                              minScale: 0.01,
                              maxScale: 1.5,
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: busanaAtasan == 'lib/assets/images/iconAtasan.png' ?
                                       Image.asset('lib/assets/images/jaket.png')
                                       : Image.network(busanaAtasan,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ) : Stack(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height*0.3,
                            margin: EdgeInsets.only(left: size.width*0.1),
                            child: InteractiveViewer(
                              boundaryMargin: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                              minScale: 0.01,
                              maxScale: 1.5,
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: busanaAtasan == 'lib/assets/images/iconAtasan.png' ?
                                       Image.asset('lib/assets/images/jaket.png')
                                       :Image.network(busanaAtasan),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: size.height*0.4,
                            margin: EdgeInsets.only(top: size.height*0.15, left: size.width*0.1),
                            child: InteractiveViewer(
                              boundaryMargin: EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                              minScale: 0.1,
                              maxScale: 1.5,
                              child: SizedBox(
                                width: 200,
                                height: 200,
                                child: busanaBawahan == 'lib/assets/images/iconBawahan.png' ?
                                       Image.asset('lib/assets/images/jeans.png')
                                       : Image.network(busanaBawahan),
                              ),
                            ),
                          )],
                      )
                  ),
                  Container(
                    height: size.height*0.5,
                    width: size.width*0.25,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: const Text('Busana'),
                        ),
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: click == 0? secondaryColor : const Color(0xD5C4C4C4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  click = 0;
                                  fittingRoom.setStatus(click);
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: busanaAtasan == "lib/assets/images/iconAtasan.png" ?
                                                 AssetImage('lib/assets/images/iconAtasan.png') as ImageProvider
                                                 : CachedNetworkImageProvider(busanaAtasan),
                                radius: 32,
                              ),
                            )
                        ),
                        const SizedBox(height: 5),
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: click == 1 ? secondaryColor : const Color(0xD5C4C4C4),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  click = 1;
                                  fittingRoom.setStatus(click);
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: busanaBawahan == "lib/assets/images/iconBawahan.png" ?
                                                 AssetImage('lib/assets/images/iconBawahan.png') as ImageProvider
                                                 : CachedNetworkImageProvider(busanaBawahan),
                                radius: 32,
                              ),
                            )
                        ),
                        const SizedBox(height: 5),
                        Container(
                          margin: EdgeInsets.only(top: 10,bottom: 5),
                          child: Text('Swap'),
                        ),//ikon pilihan bawahan
                        CircleAvatar(
                            radius: 35,
                            backgroundColor: secondaryColor,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if(swap == 0){
                                    swap = 1;
                                  } else {
                                    swap = 0;
                                  }
                                  fittingRoom.setSwap(swap);
                                });
                              },
                              child: CircleAvatar(
                                child: Icon(Icons.zoom_out_map),
                                backgroundColor: Colors.white,
                                radius: 32,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top:5,left: 10,right: 10,bottom: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 0.1,
                        offset: const Offset(0,0.5),
                      )],
                    ),
                    child: status == 0 ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: ((){
                            setState(() {
                              checkAtasan = 0;
                              index = 0;
                              fittingRoom.setIndexKategori(index);
                            });
                          }),
                          child: Container(
                            width: size.width* 0.2,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: checkAtasan == 0? secondaryColor : Colors.white,
                            ),
                            child: Text(
                                kategoriList[0].name,
                                style : TextStyle(
                                  color: checkAtasan == 0 ? Colors.white : secondaryColor,
                                )
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: ((){
                            setState(() {
                              checkAtasan = 1;
                              index = 1;
                              fittingRoom.setIndexKategori(index);
                            });
                          }),
                          child: Container(
                            width: size.width* 0.2,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: checkAtasan == 1? secondaryColor : Colors.white,
                            ),
                            child: Text(
                                kategoriList[1].name,
                                style : TextStyle(
                                  color: checkAtasan == 1 ? Colors.white : secondaryColor,
                                )
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: ((){
                            setState(() {
                              checkAtasan = 2;
                              index = 2;
                              fittingRoom.setIndexKategori(index);
                            });
                          }),
                          child: Container(
                            width: size.width* 0.2,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: checkAtasan == 2? secondaryColor : Colors.white,
                            ),
                            child: Text(
                                kategoriList[2].name,
                                style : TextStyle(
                                  color: checkAtasan == 2 ? Colors.white : secondaryColor,
                                )
                            ),
                          ),
                        ),
                      ],
                    ) : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                          onPressed: ((){
                            setState(() {
                              checkBawahan = 0;
                              index = 3;
                              fittingRoom.setIndexKategori(index);
                            });
                          }),
                          child: Container(
                            width: size.width* 0.2,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: checkBawahan == 0? secondaryColor : Colors.white,
                            ),
                            child: Text(
                                kategoriList[3].name,
                                style : TextStyle(
                                  color: checkBawahan == 0 ? Colors.white : secondaryColor,
                                )
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: ((){
                            setState(() {
                              checkBawahan = 1;
                              index = 4;
                              fittingRoom.setIndexKategori(index);
                            });
                          }),
                          child: Container(
                            width: size.width* 0.2,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: checkBawahan == 1? secondaryColor : Colors.white,
                            ),
                            child: Text(
                                kategoriList[4].name,
                                style : TextStyle(
                                  color: checkBawahan == 1 ? Colors.white : secondaryColor,
                                )
                            ),
                          ),
                        ),
                        MaterialButton(
                          onPressed: ((){
                            setState(() {
                              checkBawahan = 2;
                              index = 5;
                              fittingRoom.setIndexKategori(index);
                            });
                          }),
                          child: Container(
                            width: size.width* 0.2,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: checkBawahan == 2? secondaryColor : Colors.white,
                            ),
                            child: Text(
                                kategoriList[5].name,
                                style : TextStyle(
                                  color: checkBawahan == 2 ? Colors.white : secondaryColor,
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150.0,
                    child: Container(
                      height: 150,
                      margin: EdgeInsets.only(left: 10),
                      child: FutureBuilder(
                        future: produkApi,
                        builder: (context, AsyncSnapshot<Produk> snapshot){
                          var state = snapshot.connectionState;
                          if(state != ConnectionState.done){
                            return Center(child: CircularProgressIndicator());
                          }else{
                            if(snapshot.hasData){
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index){
                                  var produk = snapshot.data?.produk[index];
                                  return  InkWell(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      elevation: 2,
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        width: 100,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: size.height*0.001),
                                              height: size.height * 0.15,
                                              width: size.width * 1,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: CachedNetworkImageProvider(produk!.imgProduk),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        if(status == 0){
                                          fittingRoom.setBusana(produk.imgProcessing, fittingRoom.getBawahan());
                                        }else{
                                          fittingRoom.setBusana(fittingRoom.getAtasan(), produk.imgProcessing);
                                        }
                                      });
                                    },
                                  );
                                },
                                itemCount: snapshot.data?.produk.length,
                              );
                            }
                            else if(snapshot.hasError){
                              return Center(child: Text(snapshot.error.toString()));
                            }else{
                              return Text('Tidak ada Data');
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
      )
    );
  }
}