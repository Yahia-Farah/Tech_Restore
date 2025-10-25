import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../../data/models/signupmodels/sign_up_response_model.dart';
import '../entites/user_entity.dart';
import '../responses/auth_response.dart';

abstract class AuthRepository {
  Future<SignUpResponseModel> signUp(UserEntity user);
  Future<LoginResponseModel> login(LoginRequestModel request);
  Future<AuthResponse<String>> forgetPassword(String email);
  Future<AuthResponse<String>> resetPassword(
    String email,
    String newPassword,
    String code,
  );
  Future<AuthResponse<String>> resendVerifyCode(String email);
  Future<AuthResponse<String>> verifyEmail(String email, String code);
  Future<String> logout();
}
