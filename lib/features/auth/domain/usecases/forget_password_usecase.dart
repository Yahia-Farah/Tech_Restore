import 'package:injectable/injectable.dart';
import '../repo/auth_repo.dart';
import '../responses/auth_response.dart';

@injectable
class ForgetPasswordUseCase {
  final AuthRepository _forgetPasswordRepo;

  ForgetPasswordUseCase(this._forgetPasswordRepo);

  Future<AuthResponse<String>> call(String email) {
    return _forgetPasswordRepo.forgetPassword(email);
  }
}
