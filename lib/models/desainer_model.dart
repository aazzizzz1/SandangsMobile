import 'dart:convert';

Desainer desainerFromJson(String str) => Desainer.fromJson(json.decode(str));
String desainerToJson(Desainer data) => json.encode(data.toJson());

class Desainer{
  Desainer({
    required this.status,
    required this.totalResults,
    required this.desainer,
  });

  String status;
  int totalResults;
  List<DesainerElement> desainer;

  factory Desainer.fromJson(Map<String, dynamic> json) => Desainer(
    status: json["status"],
    totalResults: json["totalResults"],
    desainer: List<DesainerElement>.from(json["desainer"].map((x)
              => DesainerElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status" : status,
    "totalResults" : totalResults,
    "desainer" : List<dynamic>.from(desainer.map((x) => x.toJson())),
  };
}

class DesainerElement{
  DesainerElement({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.imgProfil,
    required this.rating,
    required this.bio,
    required this.gender,
    required this.jmlhProject,
    required this.linkPorto,
    required this.linkWa,
    required this.tarif,
  });

  String id;
  String imgProfil;
  String nama;
  String bio;
  String rating;
  String linkWa;
  String linkPorto;
  String gender;
  String jmlhProject;
  String kategori;
  String tarif;

  factory DesainerElement.fromJson(Map<String, dynamic> json) => DesainerElement(
    id: json["id"],
    nama: json["nama"],
    kategori: json["kategori"],
    imgProfil: json["img_profil"],
    rating: json["rating"],
    bio: json["bio"],
    gender: json["gender"],
    jmlhProject: json["jmlh_project"],
    linkPorto: json["link_porto"],
    linkWa: json["link_wa"],
    tarif: json["tarif"],
  );

  Map <String, dynamic> toJson() => {
    "id" : id,
    "nama" : nama,
    "kategori" : kategori,
    "img_profil" : imgProfil,
    "rating"  : rating,
    "bio" : bio,
    "gender" : gender,
    "jmlh_project" : jmlhProject,
    "link_porto" : linkPorto,
    "link_wa" : linkWa,
    "tarif" : tarif,
  };
}