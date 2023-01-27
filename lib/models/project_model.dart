import 'dart:convert';

Project projectFromJson(String str) => Project.fromJson(json.decode(str));

String projectToJson(Project data) => json.encode(data.toJson());

class Project {
  Project({
    required this.status,
    required this.totalResults,
    required this.project,
  });

  String status;
  int totalResults;
  List<ProjectElement> project;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
    status: json["status"],
    totalResults: json["totalResults"],
    project: List<ProjectElement>.from(json["project"].map((x) => ProjectElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "totalResults": totalResults,
    "project": List<dynamic>.from(project.map((x) => x.toJson())),
  };
}

class ProjectElement {
  ProjectElement({
    required this.id,
    required this.idUser,
    required this.judul,
    required this.kebutuhan,
    required this.biaya,
    required this.lampiran,
    required this.size,
    required this.linkGambar,
    required this.createdAt,
  });

  String id;
  String idUser;
  String judul;
  String kebutuhan;
  String biaya;
  String lampiran;
  String size;
  String linkGambar;
  String createdAt;

  factory ProjectElement.fromJson(Map<String, dynamic> json) => ProjectElement(
    id: json["id"],
    idUser: json["id_user"],
    judul: json["judul"],
    kebutuhan: json["kebutuhan"],
    biaya: json["biaya"],
    lampiran: json["lampiran"],
    size: json["size"],
    linkGambar: json['link_gambar'],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_user": idUser,
    "judul": judul,
    "kebutuhan": kebutuhan,
    "biaya": biaya,
    "lampiran": lampiran,
    "size": size,
    "link_gambar": linkGambar,
    "created_at": createdAt,
  };
}
