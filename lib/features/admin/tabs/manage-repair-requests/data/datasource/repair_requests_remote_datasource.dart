import '../models/repair_request_model.dart';

abstract class RepairRequestsRemoteDataSource {
  Future<RepairRequestModel> getAllRepairRequests(int page);
  Future<RepairRequestModel> getRepairRequestsByStatus(String status, int page);
}
