import 'dart:developer';
import 'dart:io';
import 'package:expense_tracker/model/model.dart';
import 'package:expense_tracker/model/transactionModel.dart';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Databaseprovider {
  static const _databaseName = "mydatabase.db";
  static const _databaseVersion = 1;

  //Fields for Category Table
  static const table = 'category';
  static const categoryColumnId = 'id';
  static const categoryColumnName = 'categoryname';
  static const categoryColumntype = 'type';

  //Fields for Transaction Table
  static const transactionTable = 'transactions';
  static const transactionId = 'id';
  static const transactionCategoryType = 'transactioncategorytype';
  static const transactionDate = 'date';
  static const transactionAmount = 'amount';
  static const transactionDescription = 'description';
  static const transactionType = 'transactionType';

  // make this a singleton class
  Databaseprovider._privateconstructor();
  static final Databaseprovider instance =
      Databaseprovider._privateconstructor();
  // only have a single app-wide referance to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // lazily instatiate the db the first time it is accesed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _oncreate);
  }

  //  SQL CODE to create the database table
  Future _oncreate(Database db, int version) async {
    await db.execute("CREATE TABLE $table("
        "$categoryColumnId INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "$categoryColumnName TEXT NOT NULL ,"
        "$categoryColumntype TEXT "
        ")");

    await db.execute("CREATE TABLE $transactionTable("
        "$transactionId INTEGER PRIMARY KEY AUTOINCREMENT ,"
        "$transactionCategoryType TEXT ,"
        "$transactionDate TEXT ,"
        "$transactionAmount TEXT ,"
        "$transactionDescription TEXT ,"
        "$transactionType TEXT "
        ")");
  }

  //Insert the Category in the Category Model
  addCategory(Categorymodel categoryModel) async {
    Database db = await instance.database;
    return await db.insert(table, categoryModel.todatabaseJson());
  }

  //Getting data from the Category Table to show in the page
  Future<List<Categorymodel>> retriveCategoriesbyExpense() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> categoryyyData = await db.query(
      table,
      where: "type = ?",
      whereArgs: ['Expense'],
    );

    return categoryyyData
        .map((e) => Categorymodel.fromdatabaseJson(e))
        .toList();
  }

  Future<List<Categorymodel>> retriveCategoriesbyIncome() async {
    final db = await instance.database;
    final List<Map<String, Object?>> categoryEData = await db.query(
      table,
      where: "type = ?",
      whereArgs: ['Income'],
    );
    return categoryEData.map((e) => Categorymodel.fromdatabaseJson(e)).toList();
  }

  //Deleting Category from the Category Model in the database
  Future<void> deleteCategory(int? id) async {
    final db = await instance.database;
    await db.delete(
      table,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //Update Category from the Category Model
  updateData(Categorymodel categoryModel) async {
    final db = await database;
    var result = await db.update(table, categoryModel.todatabaseJson(),
        where: "id = ?", whereArgs: [categoryModel.id]);
    return result;
  }

// 2nd table///////
  //TRANSACTION TABLE ALL CRUD OPERATIONS

  //For inserting the data in the database of Transaction
  addTransaction(TransactionModel transactionModel) async {
    Database newdb = await instance.database;
    return await newdb.insert(
      transactionTable,
      transactionModel.todatabaseJson(),
    );
  }

  // Fetch all the data from the Transaction Table to show in the Transaction Page
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await instance.database;
    final List<Map<String, Object?>> newallData =
        await db.query(transactionTable);
    log('Transactions $transactionTable');
    return newallData.map((e) => TransactionModel.fromdatabaseJson(e)).toList();
  }

  //Deleting the Single Transaction Entry from the Transaction Table in the database
  Future<void> deleteTransaction(int? id) async {
    final newdb = await instance.database;
    await newdb.delete(
      transactionTable,
      where: "$transactionId = ?",
      whereArgs: [id],
    );
  }

  //Updating the transaction by ID from the Transaction Table in the database
  updateTransaction(TransactionModel transactionModel) async {
    final newdb = await database;
    var result = await newdb.update(
        transactionTable, transactionModel.todatabaseJson(),
        where: "$transactionId = ?", whereArgs: [transactionModel.id]);
    return result;
  }

  //Getting data from the Category Table according to the Expense type to show in the Expense Transaction Page for Drop Down
  Future<List<Categorymodel>> retriveTransactionCategoriesbyExpense() async {
    final newdb = await instance.database;
    final List<Map<String, dynamic>> newEData = await newdb.query(
      table,
      where: "$categoryColumntype = ?",
      whereArgs: ['Expense'],
    );
    List<Categorymodel> catData = newEData.isNotEmpty
        ? newEData.map((e) => Categorymodel.fromdatabaseJson(e)).toList()
        : [];
    log('Date expense of Category $catData');
    return catData;
  }

  //Getting data from the Category Table according to the Income type to show in the Income Transaction Page for Drop Down
  Future<List<Categorymodel>> retriveTransactionCategoriesbyIncome() async {
    final newdb = await instance.database;
    final List<Map<String, dynamic>> newEData = await newdb.query(
      table,
      where: "$categoryColumntype = ?",
      whereArgs: ['Income'],
    );
    List<Categorymodel> catData = newEData.isNotEmpty
        ? newEData.map((e) => Categorymodel.fromdatabaseJson(e)).toList()
        : [];
    log('Date expense of Category $catData');
    return catData;
  }

// for transactions by expense
  Future<List<TransactionModel>> gettransactionbyExpense() async {
    final newdb = await instance.database;
    final List<Map<String, dynamic>> newEData = await newdb.query(
      transactionTable,
      where: "transactionType = ?",
      whereArgs: ['Expense'],
    );
    List<TransactionModel> homeData = newEData.isNotEmpty
        ? newEData.map((e) => TransactionModel.fromdatabaseJson(e)).toList()
        : [];
    log('Date expense of Category $homeData');
    return homeData;
  }

  //Getting the sum of the Expense Column amount
  Future getSumofExpense(String type) async {
    final db = await instance.database;
    var expenseResult = (await db.rawQuery(
        "SELECT SUM($transactionAmount) FROM $transactionTable WHERE $transactionType = ?",
        [type]));
    int expenseSumData = expenseResult[0]['SUM(amount)'] as int;
    log('Sum of Expense $expenseSumData');
    return expenseSumData;
  }

  //Getting the sum of the Income Column amount
  Future getSumofIncome(String type) async {
    final db = await instance.database;
    var incomeResult = (await db.rawQuery(
        "SELECT SUM($transactionAmount) FROM $transactionTable WHERE $transactionType = ?",
        [type]));
    int incomeSumData = incomeResult[0]['SUM(amount)'] as int;
    log('Sum of Income $incomeSumData');
    return incomeSumData;
  }
}
