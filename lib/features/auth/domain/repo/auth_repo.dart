import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../../data/models/signupmodels/sign_up_response_model.dart';
import '../entites/user_entity.dart';


abstract class AuthRepository {
  Future<SignUpResponseModel> signUp(UserEntity user);
  Future<LoginResponseModel> login(LoginRequestModel request);
}
