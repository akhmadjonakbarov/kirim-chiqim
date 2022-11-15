// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';

import '../database/dbhelper.dart';

import '../database/transaction_operations.dart';
import '../models/transaction.dart';
import 'providerclass.dart';

class Transactions extends ProviderClass {
  final dbProvider = DBHelper.instance;
  List<Transaction> _transactionsList = [
    Transaction(
      id: UniqueKey().toString(),
      personid: "personid1",
      quantity: 6000,
      dateTime: DateTime.now(),
      isEntry: false,
    ),
    Transaction(
      id: UniqueKey().toString(),
      personid: "personid1",
      quantity: 10000,
      dateTime: DateTime.now(),
      isEntry: true,
    )
  ];

  List<Transaction> get transactionsList {
    return [..._transactionsList];
  }

  double get totalSumEntry {
    double sum = 0;
    for (var transaction in _transactionsList) {
      if (transaction.isEntry) {
        sum = sum + transaction.quantity;
      } else {}
    }
    return sum;
  }

  double get totalSumExpenditure {
    double sum = 0;
    for (var transaction in _transactionsList) {
      if (transaction.isEntry != true) {
        sum = sum + transaction.quantity;
      } else {}
    }
    return sum;
  }

  double get profit {
    double entry = totalSumEntry;
    double expenditure = totalSumExpenditure;
    return entry - expenditure;
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

  Future<void> getTransactionsByPerson({String? personId}) async {
    List<Transaction> transactions =
        await TransactionsOperations.getTransactions();
    for (var transaction in transactions) {
      if (transaction.personid == personId) {
        _transactionsList.add(transaction);
      }
    }
    notifyListeners();
  }
}
