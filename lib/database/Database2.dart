// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'SessionTable.dart';
import 'UsersTable.dart';

class Databaseprovider {
  static const _databaseName = "dogdatabase.db";
  static const _databaseVersion = 1;

  static const usersTable = 'authentication';
  static const userId = 'id';
  static const userName = 'name';
  static const userEmail = 'email';
  static const userPassword = 'passwrd';
  static const cnfPassword = 'cnfpsswrd';

  static const sessionTable = 'autoLogin';
  static const autoId = 'id';
  static const autoName = 'name';
  static const autoEmail = 'email';
  static const autoPassword = 'passwrd';
  static const autocnfPassword = 'cnfpsswrd';

  static const dogTable = 'transactions';
  static const dogId = 'id';
  static const dogName = 'transactioncategorytype';
  static const buyDate = 'date';
  static const dogAge = 'amount';
  static const dogBreed = 'description';
  static const dogColor = 'transactionType';

  Databaseprovider._privateconstructor();
  static final Databaseprovider instance =
      Databaseprovider._privateconstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _oncreate);
  }

  Future _oncreate(Database db, int version) async {
    await db.execute("CREATE TABLE $dogTable("
        "$dogId INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "$dogName TEXT ,"
        "$buyDate TEXT ,"
        "$dogAge TEXT ,"
        "$dogBreed TEXT ,"
        "$dogColor TEXT "
        ")");

    await db.execute("CREATE TABLE $usersTable("
        "$userId INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "$userName TEXT ,"
        "$userEmail TEXT ,"
        "$userPassword TEXT ,"
        "$cnfPassword TEXT "
        ")");

    await db.execute("CREATE TABLE $sessionTable("
        "$autoId INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "$autoName TEXT ,"
        "$autoEmail TEXT ,"
        "$autoPassword TEXT ,"
        "$autocnfPassword TEXT "
        ")");
  }

  addSignUpdetail(UsersModel signupdetailModel) async {
    Database adddetaildb = await instance.database;
    return await adddetaildb.insert(
      usersTable,
      signupdetailModel.todatabaseJson(),
    );
  }

  addSessionDetails(SessionModel autoLogin) async {
    Database adddetaildb = await instance.database;
    return await adddetaildb.insert(
      sessionTable,
      autoLogin.todatabaseJson(),
    );
  }

  Future<Object> getUserByEmailAndPassword(
      String email, String password) async {
    final db = await database;
    var users = await db.query(usersTable,
        where: "email = ? AND passwrd = ?", whereArgs: [email, password]);
    log('users are: $users');
    return users.isNotEmpty ? users.first : Null;
  }

  Future<Object> getUserByEmail(String email) async {
    final db = await database;
    var users =
        await db.query(usersTable, where: "email = ? ", whereArgs: [email]);
    log('users are: $users');
    return users.isNotEmpty ? users.first : Null;
  }

  Future<Object> checkCurrentSession() async {
    final db = await database;
    await db.execute("CREATE TABLE IF NOT EXISTS $sessionTable("
        "$autoId INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "$autoName TEXT ,"
        "$autoEmail TEXT ,"
        "$autoPassword TEXT ,"
        "$autocnfPassword TEXT "
        ")");
    var users = await db.query(sessionTable);
    log('users are: $users');
    return users.isNotEmpty ? users.first : Null;
  }

  Future<List<UsersModel>> getAllsignUpdetail() async {
    final signupdb = await instance.database;
    final List<Map<String, Object?>> signUpallData =
        await signupdb.query(usersTable);
    return signUpallData.map((e) => UsersModel.fromdatabaseJson(e)).toList();
  }

  Future<List<SessionModel>> getAllSessionDetail() async {
    final autodb = await instance.database;
    final List<Map<String, Object?>> allSessionData =
        await autodb.query(sessionTable);
    return allSessionData.map((e) => SessionModel.fromdatabaseJson(e)).toList();
  }

  Future<void> clearSession() async {
    final newdb = await instance.database;
    await newdb.delete(
      sessionTable,
    );
  }
}
