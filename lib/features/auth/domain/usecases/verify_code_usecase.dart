import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/domain/repo/auth_repo.dart';
import '../responses/auth_response.dart';

@injectable
class VerifyCodeUseCase {
  final AuthRepository _forgetPasswordRepo;

  VerifyCodeUseCase(this._forgetPasswordRepo);

  Future<AuthResponse<String>> call(String email) {
    return _forgetPasswordRepo.resendVerifyCode(email);
  }
}
