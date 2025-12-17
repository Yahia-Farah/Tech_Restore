import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_response_model.dart';
import 'package:tech_restore/features/auth/domain/entites/shop_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<SignUpShopResponseModel> call(ShopEntity user) {
    return _authRepository.signUpShop(user);
  }
}
