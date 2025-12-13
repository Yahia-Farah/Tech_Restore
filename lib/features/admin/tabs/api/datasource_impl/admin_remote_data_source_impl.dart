import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../../data/datasource/admin_remote_datasource.dart';
import '../../data/model/admin-states/admin_states_response.dart';

@LazySingleton(as: AdminRemoteDataSource)
class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final ApiClient _apiClient;

  AdminRemoteDataSourceImpl(this._apiClient);

  @override
  Future<AdminStatesResponse> getAdminStats() async {
    return await _apiClient.getAdminStats();
  }
}