import 'package:injectable/injectable.dart';
import '../../data/models/signup_shop_models/sign_up_shop_response_model.dart';
import '../entites/delivery_entity.dart';
import '../repo/auth_repo.dart';

@injectable
class DeliverySignUpUseCase {
  final AuthRepository _authRepository;

  DeliverySignUpUseCase(this._authRepository);

  Future<SignUpShopResponseModel> call(DeliveryEntity delivery) {
    return _authRepository.signUpDelivery(delivery);
  }
}
