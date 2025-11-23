import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_request_model.dart';
import '../../domain/responses/auth_response.dart';
import '../models/forget_password_models/forget_password_request_model.dart';
import '../models/forget_password_models/reset_password_request_model.dart';
import '../models/forget_password_models/verify_email_request_model.dart';
import '../models/login_models/login_request_model.dart';
import '../models/login_models/login_response_model.dart';
import '../models/signup_shop_models/sign_up_shop_response_model.dart';
import '../models/signupmodels/sign_up_request_model.dart';
import '../models/signupmodels/sign_up_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<SignUpResponseModel> signUp(SignUpRequest request);
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<AuthResponse<String>> forgetPassword(
    ForgetPasswordRequestModel forgetPasswordRequestModel,
  );
  Future<AuthResponse<String>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  );
  Future<AuthResponse<String>> resendVerifyCode(
    ForgetPasswordRequestModel verifyCodeRequestModel,
  );
  Future<AuthResponse<String>> verifyEmail(
    VerifyEmailRequestModel verifyEmailRequestModel,
  );
  Future<String> logout();
  Future<SignUpShopResponseModel> signUpShop(SignUpShopRequestModel request);
}
