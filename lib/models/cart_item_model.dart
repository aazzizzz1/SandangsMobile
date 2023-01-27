class CartItem{
  late int? id;
  late String namaProduk;
  late String harga;
  late String gambar;
  late int jumlah;
  late int status;

  CartItem({
    this.id,
    required this.namaProduk,
    required this.harga,
    required this.gambar,
    required this.jumlah,
    required this.status,
  });

  Map<String,dynamic> toMap(){
    var map = Map<String, dynamic>();

    if(id != null){
      map['Id'] = id;
    }
    map['NamaProduk'] = namaProduk;
    map['Harga'] = harga;
    map['Gambar'] = gambar;
    map['Jumlah'] = jumlah;
    map['Status'] = status;
    return map;
  }

  CartItem.fromMap(Map<String,dynamic> map){
    id = map['Id'];
    namaProduk = map['NamaProduk'];
    harga = map['Harga'];
    gambar = map['Gambar'];
    jumlah = map['Jumlah'];
    status = map['Status'];
  }
}