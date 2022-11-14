import '../models/person.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

import '../models/transaction.dart';

class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();
  static sql.Database? _database;
  Future<sql.Database> get database async => _database ??= await _initDB();

  static Future<sql.Database> _initDB() async {
    var dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, "kirim_chiqim.db"),
      onCreate: onCreate,
      version: 1,
    );
  }

  static Future onCreate(sql.Database db, int version) async {
    await db.execute("""
      CREATE TABLE transactions(
        id PRIMARY KEY NOT NULL,
        personid TEXT NOT NULL,
        date     DATETIME NOT NULL,
        quantity REAL NOT NULL,
        kc       BOOL NOT NULL,
        FK_transactions_person STRING NOT NULL,
        FOREIGN KEY (FK_transactions_person) REFERENCES person(id)
      );""");

    await db.execute("""
      CREATE TABLE persons (
        id PRIMARY KEY NOT NULL,
        name        TEXT NOT NULL,
        phonenumber TEXT NOT NULL
      );""");
  }
}

class PersonOperations {
  PersonOperations? personOperations;

  static DBHelper dbHelperProvider = DBHelper.instance;

  static const String _personTable = "persons";

  static Future<void> insertPersons({
    String? table,
    Map<String, dynamic>? data,
  }) async {
    final sqlDB = await dbHelperProvider.database;
    if (data != null) {
      await sqlDB.insert(_personTable, data);
    }
  }

  static Future<List<Person>> getPersons() async {
    final sqlDB = await dbHelperProvider.database;
    List<Map<String, dynamic>> personsList = await sqlDB.query(_personTable);
    return personsList.map((person) => Person.fromMap(person)).toList();
  }

  static Future<int> updatePerson({Person? person}) async {
    final sqlDB = await dbHelperProvider.database;
    return await sqlDB.update(
      _personTable,
      person!.toMap(),
      where: "id = ?",
      whereArgs: [person],
    );
  }

  static Future<void> deletePerson({String? personId}) async {
    final sqlDB = await dbHelperProvider.database;
    if (personId != null) {
      sqlDB.delete(
        _personTable,
        where: "id = ?",
        whereArgs: [personId],
      );
    }
  }
}

class TransactionsOperations {
  static DBHelper dbHelperProvider = DBHelper.instance;

  TransactionsOperations? transactionsOperations;

  static const String _transactionTable = "transactions";

  static Future<void> insertTransaction(
      {String? table, Map<String, dynamic>? data}) async {
    final sqlDB = await dbHelperProvider.database;
    if (data != null) {
      await sqlDB.insert(_transactionTable, data);
    }
  }

  static Future<List<Transaction>> getTransactions() async {
    final sqlDB = await dbHelperProvider.database;
    List<Map<String, dynamic>> transactionsList =
        await sqlDB.query(_transactionTable);
    return transactionsList
        .map((transactions) => Transaction.fromMap(transactions))
        .toList();
  }

  static Future<int> updateTransactions({Transaction? transaction}) async {
    final sqlDB = await dbHelperProvider.database;
    if (transaction != null) {
      var result = sqlDB.update(_transactionTable, transaction.toMap(),
          where: "id = ?", whereArgs: []);
      return result;
    }
    return 0;
  }

  static Future<void> deleteTransaction({String? transactionsId}) async {
    final sqlDB = await dbHelperProvider.database;
    if (transactionsId != null) {
      sqlDB.delete(_transactionTable,
          where: "id = ?", whereArgs: [transactionsId]);
    }
  }
}
