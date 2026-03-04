import 'package:injectable/injectable.dart';
import '../../manage-repair-requests/data/models/repair_request_model.dart';
import '../repo/admin_repo.dart';

@injectable
class GetAdminRepairRequestsUseCase {
  final AdminRepo _adminRepo;

  GetAdminRepairRequestsUseCase(this._adminRepo);

  Future<RepairRequestModel> call(int page) async {
    return await _adminRepo.getAdminRepairRequests(page);
  }
}
