import 'package:sandangs/constant.dart';
import 'package:sandangs/models/desainer_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardDesainer extends StatelessWidget {
  const CardDesainer({required this.desainer});
  final DesainerElement desainer;

  @override
  Widget build(BuildContext context) {
      return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        width: 150,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: CircleAvatar(
                backgroundImage:  CachedNetworkImageProvider(desainer.imgProfil),
                radius: 65,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              desainer.nama,
              style: nameCard,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.star,
                  size: 20.0,
                  color: Colors.amber,
                ),
                Text(
                  desainer.rating,
                  style: ratingCard,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              desainer.bio,
              style: bioCard,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
