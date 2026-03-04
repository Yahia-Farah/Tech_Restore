import 'package:injectable/injectable.dart';
import '../../data/models/repair_request_model.dart';
import '../../data/repo/repair_requests_repo.dart';

@injectable
class GetAllRepairRequestsUseCase {
  final RepairRequestsRepo _repo;

  GetAllRepairRequestsUseCase(this._repo);

  Future<RepairRequestModel> call(int page) async {
    return await _repo.getAllRepairRequests(page);
  }
}
