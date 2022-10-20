import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/desainer_model.dart';
import 'package:sandangs/widget/gridview/feed_gridview.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailDesainer extends StatelessWidget {
  const DetailDesainer({Key? key,required this.desainer}) : super(key: key);
  final DesainerElement desainer;

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: IconButton(
          onPressed: () {Navigator.pop(context);},
          icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: secondaryColor,
          ),
        ),
        title: Text(
            'Profil Desainer',
            style: TextStyle(
              color: secondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            )
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height*0.5,
              child: Stack(
                children : [
                  Image(
                    image: AssetImage('lib/assets/images/bg-profile.jpg'),
                    fit: BoxFit.cover,
                    height: size.height*0.25,
                    width: size.width,
                  ),
                ]
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: size.height*0.2),
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  blurRadius: 2,
                  color: Colors.grey,
                )],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height*0.11,
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        desainer.nama,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      Text(
                        desainer.bio,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget> [
                          const Icon(
                              Icons.star_border,
                              color: Colors.black
                          ),
                          Text(
                              desainer.rating + '/5 ',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Poppins',
                              )
                          ),
                          Container(width: size.width*0.08),
                          Row(
                            children: <Widget> [
                              const Icon(
                                  Icons.task_outlined,
                                  color: Colors.black
                              ),
                              Text(
                                desainer.jmlhProject + ' ',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ], // <Widget>[]
                          ),
                          Container(width: size.width*0.08),
                          Row(
                            children: <Widget> [
                              ElevatedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(
                                        Icons.chat_outlined,
                                        size: 20.0
                                    ), // <-- Icon
                                    Text(
                                      ' Chat ',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w300,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ],
                                ),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(secondaryColor),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: secondaryColor)
                                    ),
                                  ),
                                ),
                                onPressed: () => _launchURL(desainer.linkWa),
                              ),
                            ], // <Widget>[]
                          ),
                        ], // <Widget>[]
                      ),
                      Container(height: size.height * 0.10),
                    ],
                  ),
                  const GridViewFeeds(),
                ],
              ),
            ),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.08,
                left: MediaQuery.of(context).size.width * 0.25,
                right: MediaQuery.of(context).size.width * 0.25,
                child: CircleAvatar(
                  radius: 88,
                  backgroundColor: const Color(0xFFFFFFFF),
                  child: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(desainer.imgProfil),
                    radius: 80,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}