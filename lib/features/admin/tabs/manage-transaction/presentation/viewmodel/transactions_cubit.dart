import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_all_transactions_usecase.dart';
import '../viewmodel/states/transactions_states.dart';

@injectable
class TransactionsCubit extends Cubit<TransactionsState> {
  final GetAllTransactionsUseCase _getAllTransactionsUseCase;
  int _currentPage = 0;

  TransactionsCubit(
    this._getAllTransactionsUseCase,
  ) : super(TransactionsInitial());

  Future<void> getAllTransactions(int page) async {
    _currentPage = page;
    emit(TransactionsLoading());
    try {
      final transactions = await _getAllTransactionsUseCase(page);
      emit(TransactionsLoaded(transactions));
    } catch (e, stackTrace) {
      emit(TransactionsError(e.toString()));
    }
  }

  void refreshTransactions() {
    getAllTransactions(_currentPage);
  }
}

