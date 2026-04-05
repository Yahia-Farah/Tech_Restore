import 'package:injectable/injectable.dart';
import '../../data/models/repair_request_model.dart';
import '../repo/repair_requests_repo.dart';

@injectable
class GetRepairRequestsByStatusUseCase {
  final RepairRequestsRepo _repo;

  GetRepairRequestsByStatusUseCase(this._repo);

  Future<RepairRequestModel> call(String status, int page) async {
    return await _repo.getRepairRequestsByStatus(status, page);
  }
}
