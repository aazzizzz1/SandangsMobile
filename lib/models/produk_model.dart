import 'dart:convert';

Produk produkFromJson(String str) => Produk.fromJson(json.decode(str));
String produkToJson(Produk data) => json.encode(data.toJson());

class Produk{
  Produk({
    required this.status,
    required this.totalResults,
    required this.produk,
  });

  String status;
  int totalResults;
  List<ProdukElement> produk;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    status: json["status"],
    totalResults: json ["totalResults"],
    produk : List<ProdukElement>.from(json["produk"].map((x) => ProdukElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status" : status,
    "totalResults" : totalResults,
    "produk" : List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class ProdukElement{
  ProdukElement({
    required this.id,
    required this.nama,
    required this.imgProduk,
    required this.imgProcessing,
    required this.harga,
    required this.rating,
    required this.deskripsi,
    required this.idDesainer,
    required this.imgDesainer,
    required this.namaDesainer,
    required this.bioDesaienr,
    required this.ratingDesainer,
    required this.waDesainer,
    required this.portoDesainer,
    required this.projekDesainer,
    required this.kategoriDesainer,
  });

  String id;
  String nama;
  String imgProduk;
  String imgProcessing;
  String harga;
  String rating;
  String deskripsi;
  String idDesainer;
  String imgDesainer;
  String namaDesainer;
  String bioDesaienr;
  String ratingDesainer;
  String waDesainer;
  String portoDesainer;
  String projekDesainer;
  String kategoriDesainer;

  factory ProdukElement.fromJson(Map<String, dynamic> json) => ProdukElement(
    id: json["id"],
    nama: json["nama"],
    imgProduk: json["img_produk"],
    imgProcessing: json["img_processing"],
    harga: json["harga"],
    rating: json["rating"],
    deskripsi: json["deskripsi"],
    idDesainer: json["id_desainer"],
    imgDesainer: json["img_profil"],
    namaDesainer: json["nama_desainer"],
    bioDesaienr: json["bio_desainer"],
    ratingDesainer: json["rating_desainer"],
    waDesainer: json["link_wa"],
    portoDesainer: json["link_porto"],
    projekDesainer: json["jmlh_project"],
    kategoriDesainer: json["kategori"],
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "nama" : nama,
    "img_produk" : imgProduk,
    "img_processing" : imgProcessing,
    "harga" : harga,
    "rating" : rating,
    "deskripsi" : deskripsi,
    "id_desainer" : idDesainer,
    "img_profil" : imgDesainer,
    "nama_desainer" : namaDesainer,
    "bio_desainer" : bioDesaienr,
    "rating_desainer" : ratingDesainer,
    "link_wa" : waDesainer,
    "link_porto" : portoDesainer,
    "jmlh_project" : projekDesainer,
    "kategori" : kategoriDesainer,
  };
}