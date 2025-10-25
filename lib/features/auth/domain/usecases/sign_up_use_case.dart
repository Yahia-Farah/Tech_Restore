import 'package:injectable/injectable.dart';

import '../../data/models/signupmodels/sign_up_response_model.dart';
import '../entites/user_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<SignUpResponseModel> call(UserEntity user) {
    return _authRepository.signUp(user);
  }
}
