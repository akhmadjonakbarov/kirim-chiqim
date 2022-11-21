// ignore_for_file: prefer_final_fields

import 'package:flutter/widgets.dart';

import '../database/dbhelper.dart';
import '../database/transaction_operations.dart';
import '../models/transaction.dart';
import './providerclass.dart';

class Transactions extends ProviderClass {
  final dbProvider = DBHelper.instance;
  List<Transaction> _transactionsList = [];

  List<Transaction> get transactionsList {
    return [..._transactionsList];
  }

  double get totalSumEntry {
    double sum = 0;
    for (var transaction in _transactionsList) {
      if (transaction.isEntry == 1) {
        sum = sum + transaction.quantity;
      } else {}
    }
    return sum;
  }

  double get totalSumExpenditure {
    double sum = 0;
    for (var transaction in _transactionsList) {
      if (transaction.isEntry != 1) {
        sum = sum + transaction.quantity;
      }
    }
    return sum;
  }

  double get profit {
    double entry = totalSumEntry;
    double expenditure = totalSumExpenditure;
    return entry - expenditure;
  }

  @override
  void add({String? personId, num? moneyQuantity, int? isEntry}) {
    Transaction newTransaction;
    if (isEntry != 1) {
      newTransaction = Transaction(
        id: UniqueKey().toString(),
        personId: personId!,
        quantity: moneyQuantity!,
        dateTime: DateTime.now(),
      );
    } else {
      newTransaction = Transaction(
        id: UniqueKey().toString(),
        personId: personId!,
        quantity: moneyQuantity!,
        isEntry: isEntry!,
        dateTime: DateTime.now(),
      );
    }

    _transactionsList.insert(0, newTransaction);
    notifyListeners();

    TransactionsOperations.insertTransaction(
      data: newTransaction.toMap(),
    );
  }

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

  Future<List<Transaction>> getTransactionsByPerson({String? personId}) async {
    List<Transaction> _list = [];
    List<Transaction> transactions =
        await TransactionsOperations.getTransactions();
    try {
      for (var tx in transactions) {
        if (tx.personId == personId) {
          _list.add(tx);
        }
      }
      return _list;
    } catch (e) {
      rethrow;
    }
  }
}
