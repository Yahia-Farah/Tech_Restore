import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';

@injectable
class DeactivateUserUseCase {
  final AdminRepo _adminRepo;

  DeactivateUserUseCase(this._adminRepo);

  Future<String> call(String userId) async {
    return await _adminRepo.deactivateUser(userId);
  }
}
