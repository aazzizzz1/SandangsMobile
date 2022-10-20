import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/produk_model.dart';
import 'package:sandangs/widget/appbar_custom/appbar_back.dart';
import 'package:sandangs/widget/bottom_menu/bottom_appbar_detail_produk.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({Key? key,required this.detail}) : super(key: key);
  final ProdukElement detail;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: const BottomAppbarDetailProduk(),
      appBar: const AppBarBack(),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.black,
              height: size.height*0.5,
              alignment: Alignment.center,
              child: Image(
                image: CachedNetworkImageProvider(widget.detail.imgProduk),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:size.height*0.4),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: Row(
                      children: [
                        Text(
                          widget.detail.nama,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Rp ' +widget.detail.harga,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: orangePrice,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal:20),
                    child: Row(
                      children: <Widget>[
                        RatingBarIndicator(
                          rating: double.parse(widget.detail.rating),
                          itemBuilder: (_, __) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                          itemSize: 20,
                        ),
                        Text(' '+ widget.detail.rating,style: const TextStyle(fontSize: 15),),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    child: Text(
                      widget.detail.deskripsi,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Divider(
                    color: greyCustom,
                    height: 20,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5, left: 30, bottom: 20),
                      child:Row(
                        children:[
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              widget.detail.imgDesainer,
                            ),
                            radius: 50,
                          ),
                          SizedBox(width: 43,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.detail.namaDesainer,
                                    style:  TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 2,),
                                  Text(
                                    'Desainer '+widget.detail.kategoriDesainer,
                                    style:  TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                child: Text("Kunjungi",
                                  style:  TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onPressed: (){
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: secondaryColor,width: 1),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.detail.ratingDesainer,
                                            style:  TextStyle(
                                              fontSize: 14,
                                              color: secondaryColor,
                                            ),
                                          ),
                                          Text(
                                              "  Penilaian"
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.detail.projekDesainer,
                                            style:  TextStyle(
                                              fontSize: 14,
                                              color: secondaryColor,
                                            ),
                                          ),
                                          Text(
                                              " Projek"
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  Divider(
                    color: greyCustom,
                    height: 0,
                    thickness: 2,
                    indent: 5,
                    endIndent: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
