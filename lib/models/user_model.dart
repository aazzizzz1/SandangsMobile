class UserList{
  late int? id;
  late String idUser;
  late String username;
  late String email;
  late String level;

  UserList({
    this.id,
    required this.idUser,
    required this.email,
    required this.level,
    required this.username,
  });

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();

    if(id != null){
      map['id'] = id;
    }
    map['idUser'] = idUser;
    map['email'] = email;
    map['username'] = username;
    map['level'] = level;

    return map;
  }

  UserList.fromMap(Map<String,dynamic> map){
    id = map['id'];
    idUser = map['idUser'];
    username = map['username'];
    level = map['level'];
    email = map['email'];
  }
}