import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/produk_model.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({Key? key, required this.produk}) : super(key: key);
  final ProdukElement produk;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            children: [
              Image(
                fit: BoxFit.fill,
                width: size.width*0.5,
                height: size.height*0.23,
                image: CachedNetworkImageProvider(
                  produk.imgProduk,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        produk.nama,
                        style: nameCard,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children : [
                        Text(
                          'Rp '+ produk.harga,
                          style: hargaCard,
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
                              produk.rating,
                              style: ratingCard,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
