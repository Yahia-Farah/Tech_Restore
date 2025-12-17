import '../../../../data/model/transaction-models/transaction_admin_response.dart';

abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final TransactionAdminModelResponse transactions;

  TransactionsLoaded(this.transactions);
}

class TransactionsError extends TransactionsState {
  final String message;

  TransactionsError(this.message);
}
