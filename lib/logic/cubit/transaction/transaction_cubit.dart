// flutter packages
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

// my flutter packages
import '../../../database/transaction_operations.dart';
import '../../../logic/models/transaction.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  double get totalSumEntry {
    double sum = 0.0;
    if (state.transactions != null && state.transactions!.isNotEmpty) {
      for (var transaction in state.transactions!) {
        if (transaction.isEntry == 1) {
          sum = sum + transaction.quantity;
        }
      }
    }
    return sum;
  }

  double get totalSumExpenditure {
    double sum = 0.0;
    if (state.transactions != null && state.transactions!.isNotEmpty) {
      for (var transaction in state.transactions!) {
        if (transaction.isEntry != 1) {
          sum = sum + transaction.quantity;
        }
      }
    }
    return sum;
  }

  double get profit {
    double entry = totalSumEntry;
    double expenditure = totalSumExpenditure;
    return entry - expenditure;
  }

  Future<void> getTransactions({String? personId}) async {
    List<Transaction> transactions =
        await TransactionsOperations.getTransactions();

    emit(TransactionLoading());

    List<Transaction> userTransactions =
        transactions.where((element) => element.personId == personId).toList();

    emit(TransactionLoaded(transactions: userTransactions));

    // state == TransactionInitial -> bu esa null qaytaradi shuning uchun ko'rsatmayap
    // print(state);
    // if (state.transactions != null) {
    //   transactions = state.transactions!
    //       .where((element) => element.id == personId)
    //       .toList();

    //   emit(TransactionLoaded(transactions: transactions));
    // }
  }

  void add({String? personId, num? moneyQuantity, int? isEntry}) {
    List<Transaction> transactions = [];
    Transaction newTransaction;
    if (state.transactions == [] || state.transactions == null) {
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
      emit(TransactionLoaded(transactions: transactions));
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
