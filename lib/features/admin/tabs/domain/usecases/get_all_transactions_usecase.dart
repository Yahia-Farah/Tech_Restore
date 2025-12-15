import 'package:injectable/injectable.dart';
import '../../data/model/transaction-models/transaction_admin_response.dart';
import '../repo/admin_repo.dart';

@injectable
class GetAllTransactionsUseCase {
  final AdminRepo _adminRepo;

  GetAllTransactionsUseCase(this._adminRepo);

  Future<TransactionAdminModelResponse> call(int page) async {
    return await _adminRepo.getAllTransactions(page);
  }
}

