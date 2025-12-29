import 'package:equatable/equatable.dart';

abstract class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final double totalSalesRevenue;
  final double totalRepairRevenue;
  final double totalProfit;

  const TransactionsLoaded({
    required this.totalSalesRevenue,
    required this.totalRepairRevenue,
    required this.totalProfit,
  });

  @override
  List<Object?> get props => [
    totalSalesRevenue,
    totalRepairRevenue,
    totalProfit,
  ];
}

class TransactionsError extends TransactionsState {
  final String message;

  const TransactionsError(this.message);

  @override
  List<Object?> get props => [message];
}
