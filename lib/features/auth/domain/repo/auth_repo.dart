import '../../data/models/signupmodels/sign_up_response_model.dart';
import '../entites/user_entity.dart';


abstract class AuthRepository {
  Future<SignUpResponseModel> signUp(UserEntity user);
}
