import 'dbhelper.dart';

import '../models/transaction.dart';

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

  static Future<List<Transaction>> getTransactionsNyUserId(
      {String? personId}) async {
    final sqlDB = await dbHelperProvider.database;
    var result = [];
    List<Map<String, dynamic>> transactionsList =
        await sqlDB.query(_transactionTable);
    for (var transaction in transactionsList) {
      if (transaction['personId'] == personId) {
        result.add(transaction);
      }
    }
    return result as List<Transaction>;
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
