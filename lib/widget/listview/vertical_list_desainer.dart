import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/desainer_model.dart';

class VerticalListDesainer extends StatelessWidget {
  const VerticalListDesainer({Key? key,required this.desainer}) : super(key: key);
  final DesainerElement desainer;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child:Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 1,
          shadowColor: Colors.black,
          child: Padding(
              padding: EdgeInsets.only(
                  top: 13,
                  left: 30,
                  bottom: 13
              ),
              child:Row(
                children:[
                  CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(desainer.imgProfil),
                    radius: 40,
                  ),
                  SizedBox(width: 40,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              desainer.nama,
                              style: titleVerticalCardTextStyle,
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Desainer ' + desainer.kategori,
                              style: subtitleVerticalCardTextStyle,
                            ),
                          ],
                        ),
                        SizedBox(height: 15,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(desainer.rating + '/5'),
                                    Icon(
                                        Icons.star_border,
                                        color: Colors.black,
                                        size: 18
                                    ),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(desainer.jmlhProject+ ' '),
                                    Icon(
                                        Icons.task_outlined,
                                        color: Colors.black,
                                        size: 18
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )
          ),
        )
    );
  }
}