import 'package:kirim_chiqim/models/person.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class PersonDBHelper {
  static const String _tableName = "persons";
  static Future<sql.Database> initDB() async {
    var dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(
      path.join(dbPath, "persons.dart"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $_tableName (id PRIMARY KEY NOT NULL , name TEXT NOT NULL, phoneNumber TEXT NOT NULL);",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertPersons(
      {String? table, Map<String, dynamic>? data}) async {
    final sqlDB = await PersonDBHelper.initDB();
    if (data != null) {
      sqlDB.insert(_tableName, data);
    }
  }

  static Future<List<Person>> getPersons() async {
    final sqlDB = await PersonDBHelper.initDB();
    List<Map<String, dynamic>> personsList = await sqlDB.query(_tableName);
    return personsList.map((person) => Person.fromMap(person)).toList();
  }

  static Future<int> updatePerson({Person? person}) async {
    final sqlDB = await PersonDBHelper.initDB();
    return await sqlDB.update(
      _tableName,
      person!.toMap(),
      where: "id = ?",
      whereArgs: [person],
    );
  }

  static Future<void> deletePerson({String? personId}) async {
    final sqlDB = await PersonDBHelper.initDB();
    if (personId != null) {
      sqlDB.delete(
        _tableName,
        where: "id = ?",
        whereArgs: [personId],
      );
    }
  }
}

class TransactionDBHelper {}
