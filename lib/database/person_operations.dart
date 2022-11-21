import '../models/person.dart';
import 'dbhelper.dart';

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
      whereArgs: [person.id],
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
