import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_all_transactions_usecase.dart';
import 'states/transactions_states.dart';

@injectable
class TransactionsCubit extends Cubit<TransactionsState> {
  final GetAllTransactionsUseCase _getAllTransactionsUseCase;
  int _currentPage = 0;

  TransactionsCubit(this._getAllTransactionsUseCase)
      : super(TransactionsInitial());

  String _extractErrorMessage(dynamic error) {
    if (error is Exception) {
      final message = error.toString();
      if (message.startsWith('Exception: ')) {
        return message.substring(11); // Remove 'Exception: ' prefix
      }
      return message;
    }
    return error.toString();
  }

  Future<void> getAllTransactions(int page) async {
    _currentPage = page;
    emit(TransactionsLoading());
    try {
      final transactions = await _getAllTransactionsUseCase(page);
      emit(TransactionsLoaded(transactions));
    } catch (e) {
      emit(TransactionsError(_extractErrorMessage(e)));
    }
  }

  void refreshTransactions() {
    getAllTransactions(_currentPage);
  }
}

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import '../../../domain/usecases/get_all_transactions_usecase.dart';
// import '../viewmodel/states/transactions_states.dart';
//
// @injectable
// class TransactionsCubit extends Cubit<TransactionsState> {
//   final GetAllTransactionsUseCase _getAllTransactionsUseCase;
//   int _currentPage = 0;
//
//   TransactionsCubit(this._getAllTransactionsUseCase)
//     : super(TransactionsInitial());
//
//   String _extractErrorMessage(dynamic error) {
//     if (error is Exception) {
//       final message = error.toString();
//       if (message.startsWith('Exception: ')) {
//         return message.substring(11); // Remove 'Exception: ' prefix
//       }
//       return message;
//     }
//     return error.toString();
//   }
//
//   Future<void> getAllTransactions(int page) async {
//     _currentPage = page;
//     emit(TransactionsLoading());
//     try {
//       final transactions = await _getAllTransactionsUseCase(page);
//       emit(TransactionsLoaded(transactions));
//     } catch (e) {
//       emit(TransactionsError(_extractErrorMessage(e)));
//     }
//   }
//
//   void refreshTransactions() {
//     getAllTransactions(_currentPage);
//   }
// }
//
