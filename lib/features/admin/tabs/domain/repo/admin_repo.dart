import '../../data/model/admin-states/admin_states_response.dart';

abstract class AdminRepo {
  Future<AdminStatesResponse> getAdminStats();
}
