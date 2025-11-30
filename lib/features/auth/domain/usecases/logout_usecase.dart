import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/domain/repo/auth_repo.dart';

@injectable
class LogoutUseCase {
  final AuthRepository _authRepo;
  LogoutUseCase(this._authRepo);

  Future<String> call() async {
    return await _authRepo.logout();
  }
}
