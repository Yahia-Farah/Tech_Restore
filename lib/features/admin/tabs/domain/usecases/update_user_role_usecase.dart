import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';
import '../../manage-user/data/models/update_user_role_request.dart';

@injectable
class UpdateUserRoleUseCase {
  final AdminRepo _adminRepo;

  UpdateUserRoleUseCase(this._adminRepo);

  Future<String> call(String userId, UpdateUserRoleRequest request) async {
    return await _adminRepo.updateUserRole(userId, request);
  }
}
