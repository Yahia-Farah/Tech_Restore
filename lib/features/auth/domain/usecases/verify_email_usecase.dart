import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/domain/repo/auth_repo.dart';
import '../responses/auth_response.dart';

@injectable
class VerifyEmailUseCase {
  final AuthRepository _authRepo;

  VerifyEmailUseCase(this._authRepo);

  Future<AuthResponse<String>> call(String email, String code) {
    return _authRepo.verifyEmail(email, code);
  }
}
