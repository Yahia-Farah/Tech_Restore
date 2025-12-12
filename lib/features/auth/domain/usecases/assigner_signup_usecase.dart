import 'package:injectable/injectable.dart';
import '../../data/models/signup_shop_models/sign_up_shop_response_model.dart';
import '../entites/assigner_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class AssignerSignupUseCase {
  final AuthRepository _authRepository;

  AssignerSignupUseCase(this._authRepository);

  Future<SignUpShopResponseModel> call(AssignerEntity assigner) {
    return _authRepository.signUpAssigner(assigner);
  }
}
