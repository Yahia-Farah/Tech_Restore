import '../models/login_models/login_request_model.dart';
import '../models/login_models/login_response_model.dart';
import '../models/signupmodels/sign_up_request_model.dart';
import '../models/signupmodels/sign_up_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignUpResponseModel> signUp(SignUpRequest request);
  Future<LoginResponseModel> login(LoginRequestModel request);

}