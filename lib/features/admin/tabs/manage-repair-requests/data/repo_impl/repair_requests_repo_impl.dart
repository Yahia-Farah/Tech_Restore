import 'package:injectable/injectable.dart';
import '../../domain/repo/repair_requests_repo.dart';
import '../datasource/repair_requests_remote_datasource.dart';
import '../models/repair_request_model.dart';

@Injectable(as: RepairRequestsRepo)
class RepairRequestsRepoImpl implements RepairRequestsRepo {
  final RepairRequestsRemoteDataSource _remoteDataSource;

  RepairRequestsRepoImpl(this._remoteDataSource);

  @override
  Future<RepairRequestModel> getAllRepairRequests(int page) async {
    return await _remoteDataSource.getAllRepairRequests(page);
  }

  @override
  Future<RepairRequestModel> getRepairRequestsByStatus(String status, int page) async {
    return await _remoteDataSource.getRepairRequestsByStatus(status, page);
  }
}
