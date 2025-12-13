import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';

@injectable
class ActivateUserUseCase {
  final AdminRepo _adminRepo;

  ActivateUserUseCase(this._adminRepo);

  Future<String> call(String userId) async {
    return await _adminRepo.activateUser(userId);
  }
}

