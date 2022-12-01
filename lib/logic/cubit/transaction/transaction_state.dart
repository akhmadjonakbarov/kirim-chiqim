part of 'transaction_cubit.dart';

abstract class TransactionState {
  List<Transaction>? transactions;
  TransactionState({this.transactions});
}

class TransactionWelcome extends TransactionState {}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<Transaction> transactions;
  TransactionLoaded({required this.transactions})
      : super(transactions: transactions);
}

class TransactionError extends TransactionState {
  final String errorMessage;
  TransactionError({required this.errorMessage});
}
