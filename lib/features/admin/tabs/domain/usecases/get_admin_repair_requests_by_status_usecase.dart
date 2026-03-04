import 'package:injectable/injectable.dart';
import '../../manage-repair-requests/data/models/repair_request_model.dart';
import '../repo/admin_repo.dart';

@injectable
class GetAdminRepairRequestsByStatusUseCase {
  final AdminRepo _adminRepo;

  GetAdminRepairRequestsByStatusUseCase(this._adminRepo);

  Future<RepairRequestModel> call(String status, int page) async {
    return await _adminRepo.getAdminRepairRequestsByStatus(status, page);
  }
}
