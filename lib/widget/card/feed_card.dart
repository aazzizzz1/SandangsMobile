import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/models/produk_model.dart';

class FeedsCard extends StatelessWidget {
  const FeedsCard({required this.produk});
  final ProdukElement produk;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Stack(
        children: [
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                fit: BoxFit.fill,
                width: size.width * 0.5,
                height: size.height * 0.18,
                image: CachedNetworkImageProvider(
                  produk.imgProduk,
                ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.19,
            left: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  produk.nama,
                  style : TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 15,
                      color: Colors.amber,
                    ),
                    Text(
                      produk.rating+"/5",
                      style : TextStyle(
                        fontSize: 11,
                        // fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
