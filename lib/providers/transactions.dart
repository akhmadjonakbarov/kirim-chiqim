// ignore_for_file: prefer_final_fields

import '../database/dbhelper.dart';

import '../database/transaction_operations.dart';
import '../models/transaction.dart';
import 'providerclass.dart';

class Transactions extends ProviderClass {
  final dbProvider = DBHelper.instance;
  List<Transaction> _transactionsList = [];

  List<Transaction> get transactionsList {
    return [...transactionsList];
  }

  @override
  void add() {}

  @override
  void update({Transaction? transaction}) {
    if (transaction != null) {
      int indexOfTransaction = _transactionsList.indexWhere(
        (element) => element.id == transaction.id,
      );
      _transactionsList[indexOfTransaction] = transaction;
      notifyListeners();
    }
  }

  @override
  void delete({String? transactionId}) {
    if (transactionId != null) {
      _transactionsList
          .removeWhere((transaction) => transaction.id == transactionId);
      notifyListeners();
      TransactionsOperations.deleteTransaction(
        transactionsId: transactionId,
      );
    }
  }

  // Future<List> getTransactions() async {
  //   final sqlDB = await dbProvider.database;
  //   List<Transaction> transactionsList = sqlDB.
  // }
}
