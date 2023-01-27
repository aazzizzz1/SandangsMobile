import 'package:flutter/cupertino.dart';
import 'package:sandangs/models/cart_item_model.dart';
import 'package:sandangs/widget/db_helper/db_cart_produk.dart';

class KeranjangProv with ChangeNotifier{
  int jumlah = 0;

  Future<int> getJumlah() async{
    jumlah = await _getAllKeranjang();
    return jumlah;
  }

  jumlahplus()async{
    jumlah = await _getAllKeranjang();
    notifyListeners();
  }
}
Future<int> _getAllKeranjang() async{
  DbHelperCart db = DbHelperCart();
  List<CartItem> listKeranjang = [];
  var list = await db.getAllKeranjang();
  listKeranjang.clear();
  list!.forEach((keranjang) {
    listKeranjang.add(CartItem.fromMap(keranjang));
  });
  return listKeranjang.length;
}