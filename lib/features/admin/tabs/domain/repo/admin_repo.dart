import '../../data/model/admin-states/admin_states_response.dart';
import '../../manage-user/data/models/update_user_role_request.dart';

abstract class AdminRepo {
  Future<AdminStatesResponse> getAdminStats();
  Future<String> updateUserRole(String userId, UpdateUserRoleRequest request);
  Future<String> deactivateUser(String userId);
  Future<String> activateUser(String userId);
}
