import 'dart:convert';

Konveksi konveksiFromJson(String str) => Konveksi.fromJson(json.decode(str));

String konveksiToJson(Konveksi data) => json.encode(data.toJson());

class Konveksi {
  Konveksi({
    required this.status,
    required this.totalResults,
    required this.konveksi,
  });

  String status;
  int totalResults;
  List<KonveksiElement> konveksi;

  factory Konveksi.fromJson(Map<String, dynamic> json) => Konveksi(
    status: json["status"],
    totalResults: json["totalResults"],
    konveksi: List<KonveksiElement>.from(json["konveksi"].map((x) => KonveksiElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "konveksi": List<dynamic>.from(konveksi.map((x) => x.toJson())),
  };
}

class KonveksiElement {
  KonveksiElement({
    required this.id,
    required this.imgProfil,
    required this.nama,
    required this.bio,
    required this.rating,
    required this.linkWa,
    required this.linkPorto,
    required this.jmlhProject,
    required this.kategori,
    required this.tarif,
  });

  String id;
  String imgProfil;
  String nama;
  String bio;
  String rating;
  String linkWa;
  String linkPorto;
  String jmlhProject;
  String kategori;
  String tarif;

  factory KonveksiElement.fromJson(Map<String, dynamic> json) => KonveksiElement(
    id: json["id"],
    imgProfil: json["img_profil"],
    nama: json["nama"],
    bio: json["bio"],
    rating: json["rating"],
    linkWa: json["link_wa"],
    linkPorto: json["link_porto"],
    jmlhProject: json["jmlh_project"],
    kategori: json["kategori"],
    tarif: json["tarif"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "img_profil": imgProfil,
    "nama": nama,
    "bio": bio,
    "rating": rating,
    "link_wa": linkWa,
    "link_porto": linkPorto,
    "jmlh_project": jmlhProject,
    "kategori": kategori,
    "tarif": tarif,
  };
}
