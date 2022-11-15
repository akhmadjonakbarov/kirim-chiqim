import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;

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
        phoneNumber TEXT NOT NULL
      );""");
  }
}
