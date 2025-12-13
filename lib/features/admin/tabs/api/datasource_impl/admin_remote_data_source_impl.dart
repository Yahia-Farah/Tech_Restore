import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../../data/datasource/admin_remote_datasource.dart';
import '../../data/model/admin-states/admin_states_response.dart';
import '../../manage-user/data/models/update_user_role_request.dart';

@LazySingleton(as: AdminRemoteDataSource)
class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final ApiClient _apiClient;

  AdminRemoteDataSourceImpl(this._apiClient);

  @override
  Future<AdminStatesResponse> getAdminStats() async {
    return await _apiClient.getAdminStats();
  }

  @override
  Future<String> updateUserRole(String userId, UpdateUserRoleRequest request) async {
    return await _apiClient.updateUserRole(userId, request);
  }

  @override
  Future<String> deactivateUser(String userId) async {
    return await _apiClient.deactivateUser(userId);
  }

  @override
  Future<String> activateUser(String userId) async {
    return await _apiClient.activateUser(userId);
  }
}