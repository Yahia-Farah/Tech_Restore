import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/domain/repo/auth_repo.dart';
import '../responses/auth_response.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepository _forgetPasswordRepo;

  ResetPasswordUseCase(this._forgetPasswordRepo);

  Future<AuthResponse<String>> call(
    String email,
    String newPassword,
    String code,
  ) {
    return _forgetPasswordRepo.resetPassword(email, newPassword, code);
  }
}
