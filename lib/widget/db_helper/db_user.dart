import 'package:sandangs/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelperUser{
  static final DbHelperUser _instance = DbHelperUser._internal();
  static Database? database;
  final String tableName = 'tableUser';
  final String columnId = 'id';
  final String columnIDUser = 'idUser';
  final String columnEmail = 'email';
  final String columnUsername = 'username';
  final String columnLevel = 'level';

  DbHelperUser._internal();
  factory DbHelperUser() => _instance;

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnIDUser TEXT,"
        "$columnEmail TEXT,"
        "$columnUsername TEXT,"
        "$columnLevel TEXT)";
    await db.execute(sql);
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user.db');

    return await openDatabase(path, version:1,onCreate:_onCreate);
  }

  Future<Database?> get _db async{
    if(database != null){
      return database;
    }
    database = await _initDb();
    return database;
  }

  Future<int?> saveUser(UserList user) async {
    var dbclient = await _db;
    return await dbclient!.insert(tableName, user.toMap());
  }

  Future<List?> getUser() async {
    var dbclient = await _db;
    var result = await dbclient!.query(tableName,columns: [
      columnId,
      columnIDUser,
      columnUsername,
      columnEmail,
      columnLevel,
    ]);

    return result.toList();
  }

  Future<int?> updateUser(UserList myUser) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, myUser.toMap(), where: '$columnId = ?', whereArgs: [myUser.id]);
  }

  Future<void> clearUser() async {
    var dbclient = await _db;
    String clearDBQuery = "DELETE FROM " + tableName;
    return await dbclient!.execute(clearDBQuery);
    // return await dbclient!.delete(tableName,where: '$columnId = ?',whereArgs: [id]);
  }
}