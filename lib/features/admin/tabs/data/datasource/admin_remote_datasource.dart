import '../model/admin-states/admin_states_response.dart';

abstract class AdminRemoteDataSource {
  Future<AdminStatesResponse> getAdminStats();
}