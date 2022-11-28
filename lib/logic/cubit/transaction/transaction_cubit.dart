import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kirim_chiqim/database/transaction_operations.dart';

import 'package:kirim_chiqim/logic/models/transaction.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void add({String? personId, num? moneyQuantity, int? isEntry}) {
    List<Transaction> transactions = [];
    Transaction newTransaction;
    if (state.transactions!.isEmpty || state.transactions == null) {
      transactions = [];
    } else {
      transactions = state.transactions!;
    }
    try {
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
      transactions.add(newTransaction);
      TransactionsOperations.insertTransaction(
        data: newTransaction.toMap(),
      );
    } catch (e) {
      emit(
        TransactionError(errorMessage: e.toString()),
      );
    }
  }

  void update({Transaction? transaction}) {
    if (transaction != null) {
      int indexOfTr = state.transactions!
          .indexWhere((element) => element.id == transaction.id);
      state.transactions![indexOfTr] = transaction;
      TransactionsOperations.updateTransactions(transaction: transaction);
    }
  }

  void deleteTransaction({String? trId}) {
    if (trId != null) {
      state.transactions!.removeWhere((element) => element.id == trId);
      TransactionsOperations.deleteTransaction(transactionsId: trId);
    }
  }
}
