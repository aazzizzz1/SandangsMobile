import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sandangs/constant.dart';
import 'package:sandangs/models/cart_item_model.dart';
import 'package:sandangs/models/produk_model.dart';
import 'package:sandangs/widget/db_helper/db_cart_produk.dart';
import 'package:sandangs/widget/provider/cart_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';


class BottomAppbarDetailProduk extends StatefulWidget {
  const BottomAppbarDetailProduk({Key? key, required this.detail}) : super(key: key);
  final ProdukElement detail;

  @override
  State<BottomAppbarDetailProduk> createState() => _BottomAppbarDetailProdukState();
}

class _BottomAppbarDetailProdukState extends State<BottomAppbarDetailProduk> {
  DbHelperCart db = DbHelperCart();
  List<CartItem> listKeranjang = [];
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var keranjang = Provider.of<KeranjangProv>(context,listen: true);

    setState(() {
      _getAllKeranjang();
      keranjang.jumlahplus();
    });
    return BottomAppBar(
      elevation: 1,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
        ),
        height: size.height*0.07,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: size.width*0.18,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal:5,vertical: 5),
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: Colors.white,
                  ),
                  iconSize: 25,
                  onPressed: (){
                    EasyLoading.showSuccess('Dimasukkan ke Keranjang');
                    upsertKeranjang(widget.detail.nama);
                    setState(() {
                      _getAllKeranjang();
                      keranjang.jumlahplus();
                    });
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width*0.70,
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal:5,vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: orangePrice,
                ),
                child: TextButton(
                  onPressed: (){
                    _launchURL('https://api.whatsapp.com/send?phone=6285808322783&text=Transaksi%20akan%20dialihkan%20ke%20admin%20Fashionizt');
                  },
                  child: Text(
                    'Beli Sekarang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> upsertKeranjang(String Nama) async {
    bool status = false;
    CartItem? keranjang;
    for(int i = 0;i<listKeranjang.length;i++){
      if(listKeranjang[i].namaProduk == Nama){
        status = true;
        keranjang = listKeranjang[i];
      }
    }

    if(status == true){
      await db.updateKeranjang(CartItem.fromMap({
        'Id' : keranjang!.id,
        'NamaProduk' : keranjang.namaProduk,
        'Harga' : keranjang.harga,
        'Jumlah' : keranjang.jumlah+1,
        'Gambar' : keranjang.gambar,
        'Status' : keranjang.status,
      }));
    }else{
      await db.saveKeranjang(CartItem(
        namaProduk: widget.detail.nama,
        harga: widget.detail.harga,
        gambar: widget.detail.imgProduk,
        jumlah: 1,
        status: 0,
      ));
    }
    _getAllKeranjang();
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
}
