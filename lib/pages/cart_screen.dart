import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/cart_item_model.dart';
import 'package:sandangs/pages/empty_cart.dart';
import 'package:sandangs/widget/db_helper/db_cart_produk.dart';
import 'package:sandangs/widget/provider/cart_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartItem> listKeranjang = [];
  DbHelperCart db = DbHelperCart();
  int total = 0;

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  void initState(){
    _getAllKeranjang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final width = MediaQuery.of(context).size.width;
    var mycart = Provider.of<KeranjangProv>(context,listen: true);

    return listKeranjang.isEmpty ? Scaffold (body: CartEmpty()) : Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
          ),
          height: size.height*0.07,
          child: Row(
            children: [
              Container(
                width: size.width*0.55,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                        'Total : ',
                        style:
                        TextStyle(color: blackColor, fontSize: 15.0)
                    ),
                    Text(
                      hitungTotal().toString(),
                      style: TextStyle(
                        color: orangePrice,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                width: size.width*0.4,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: orangePrice,
                ),
                child:  TextButton(
                  onPressed: () {
                    _launchURL('https://api.whatsapp.com/send?phone=6285808322783&text=Saya%20pesan%20produk%20dengan%20total%20harga%20:%20%0A'+hitungTotal().toString());
                  },
                  child: const Text('Check Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          color: secondaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Keranjang',
          style: tittleDark,
        ),
      ),
      body: ListView.builder(
          itemCount: listKeranjang.length,
          itemBuilder: (context,index){
            CartItem keranjang = listKeranjang[index];
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  Checkbox(
                      activeColor: secondaryColor,
                      value: keranjang.status == 0 ? false : true,
                      onChanged: (bool? value){
                        setState(() {
                          statusKeranjang(keranjang);
                          _getAllKeranjang();
                        });
                      }
                  ),
                  SizedBox(
                    width: 100,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              image: CachedNetworkImageProvider('${keranjang.gambar}'),
                              fit: BoxFit.fill,
                              width: size.width*0.5,
                              height: size.height*0.23,
                            ),
                          ),
                          //child: Image.network('${keranjang.Gambar}'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${keranjang.namaProduk}',
                        style: TextStyle(color: Colors.black, fontSize: width*0.04),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10),
                      Text.rich(
                        TextSpan(
                          text: "\Rp ${keranjang.harga}",
                          style: TextStyle(fontWeight: FontWeight.w600, color: orangePrice),
                        ),
                      ),
                      Container(
                        height: size.height*0.03,
                        width: size.width*0.25,
                        margin:
                        EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(4),
                            border: Border.all(
                                color: secondaryColor)
                        ),
                        child : Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                kurangProduk(keranjang, index);
                                setState(() {
                                  _getAllKeranjang();
                                });
                              },
                              child: Icon(
                                Icons.remove,
                                color: secondaryColor,
                                size: 22,
                              ),
                            ),
                            Text(
                              "${keranjang.jumlah}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0),
                            ),
                            InkWell(
                              onTap: () {
                                tambahProduk(keranjang);
                                setState(() {
                                  _getAllKeranjang();
                                });
                              },
                              child: Icon(
                                Icons.add,
                                color: secondaryColor,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: (){
                      _deleteKeranjang(keranjang, index);
                      setState(() {
                        _getAllKeranjang();
                        mycart.jumlahplus();
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<void> _getAllKeranjang() async {
    var list = await db.getAllKeranjang();
    setState(() {
      listKeranjang.clear();
      list!.forEach((keranjang) {
        listKeranjang.add(CartItem.fromMap(keranjang));
      });
    });
  }
  String hitungTotal(){
    double total = 0;
    String output = "0";

    for(int i=0; i < listKeranjang.length; i++){
      if(listKeranjang[i].status == 1){
        total = total +  (double.parse(listKeranjang[i].harga) * listKeranjang[i].jumlah);
      }
    }

    if(total/1000 >= 1){
      output = (total/1000).toInt().toString()+ "."+ (1000+(total%1000)).toString().substring(1,4)+ ".000";
    }else if(total > 0 && total < 1000) {
      output = total.toInt().toString()+".000";
    }
    return "Rp " + output;
  }

  Future<void> _deleteKeranjang(CartItem keranjang, int position) async {
    await db.deleteKeranjang(keranjang.id!);

    setState(() {
      listKeranjang.removeAt(position);
    });
  }
  Future<void> tambahProduk(CartItem keranjang) async{
    await db.updateKeranjang(CartItem.fromMap({
      'Id' : keranjang.id,
      'NamaProduk' : keranjang.namaProduk,
      'Harga' : keranjang.harga,
      'Jumlah' : keranjang.jumlah+1,
      'Gambar' : keranjang.gambar,
      'Status' : keranjang.status,
    }));
  }
  Future<void> statusKeranjang(CartItem keranjang) async{
    if(keranjang.status == 1){
      await db.updateKeranjang(CartItem.fromMap({
        'Id' : keranjang.id,
        'NamaProduk' : keranjang.namaProduk,
        'Harga' : keranjang.harga,
        'Jumlah' : keranjang.jumlah,
        'Gambar' : keranjang.gambar,
        'Status' : 0,
      }));
    }else{
      await db.updateKeranjang(CartItem.fromMap({
        'Id' : keranjang.id,
        'NamaProduk' : keranjang.namaProduk,
        'Harga' : keranjang.harga,
        'Jumlah' : keranjang.jumlah,
        'Gambar' : keranjang.gambar,
        'Status' : 1,
      }));
    }
  }
  Future<void> kurangProduk(CartItem keranjang,int index) async{
    if(keranjang.jumlah-1 == 0){
      _deleteKeranjang(keranjang, index);
    }else{
      await db.updateKeranjang(CartItem.fromMap({
        'Id' : keranjang.id,
        'NamaProduk' : keranjang.namaProduk,
        'Harga' : keranjang.harga,
        'Jumlah' : keranjang.jumlah-1,
        'Gambar' : keranjang.gambar,
        'Status' : keranjang.status,
      }));
    }
  }
}