import 'package:injectable/injectable.dart';
import '../../domain/repo/admin_repo.dart';
import '../../data/datasource/admin_remote_datasource.dart';
import '../model/admin-states/admin_states_response.dart';
import '../../manage-user/data/models/update_user_role_request.dart';

@Injectable(as: AdminRepo)
class AdminRepoImpl implements AdminRepo {
  final AdminRemoteDataSource _remoteDataSource;

  AdminRepoImpl(this._remoteDataSource);

  @override
  Future<AdminStatesResponse> getAdminStats() async {
    return await _remoteDataSource.getAdminStats();
  }

  @override
  Future<String> updateUserRole(String userId, UpdateUserRoleRequest request) async {
    return await _remoteDataSource.updateUserRole(userId, request);
  }

  @override
  Future<String> deactivateUser(String userId) async {
    return await _remoteDataSource.deactivateUser(userId);
  }

  @override
  Future<String> activateUser(String userId) async {
    return await _remoteDataSource.activateUser(userId);
  }
}
