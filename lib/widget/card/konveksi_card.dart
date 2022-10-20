import 'package:sandangs/constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/models/konveksi_model.dart';

class CardKonveksi extends StatelessWidget {
  const CardKonveksi({required this.konveksi});
  final KonveksiElement konveksi;

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
                backgroundImage:  CachedNetworkImageProvider(konveksi.imgProfil),
                radius: 65,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              konveksi.nama,
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
                  konveksi.rating,
                  style: ratingCard,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              konveksi.bio,
              style: bioCard,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
