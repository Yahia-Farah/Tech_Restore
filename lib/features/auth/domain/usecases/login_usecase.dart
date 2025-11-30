import 'package:injectable/injectable.dart';

import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../repo/auth_repo.dart';

@injectable
class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<LoginResponseModel> call(LoginRequestModel request) {
    return _authRepository.login(request);
  }
}
