import 'package:tech_restore/features/auth/data/models/signup_assigner_model/signup_assigner_request_model.dart';
import 'package:tech_restore/features/auth/data/models/signup_delivery_models/signup_delivery_request_model.dart';
import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_response_model.dart';
import 'package:tech_restore/features/auth/domain/entites/assigner_entity.dart';
import 'package:tech_restore/features/auth/domain/entites/delivery_entity.dart';
import 'package:tech_restore/features/auth/domain/entites/shop_entity.dart';
import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../../data/models/signupmodels/sign_up_response_model.dart';
import '../entites/user_entity.dart';
import '../responses/auth_response.dart';

abstract class AuthRepository {
  Future<SignUpResponseModel> signUp(UserEntity user);
  Future<SignUpShopResponseModel> signUpShop(ShopEntity shop);
  Future<SignUpShopResponseModel> signUpDelivery(DeliveryEntity delivery);
  Future<SignUpShopResponseModel> signUpAssigner(AssignerEntity assigner);
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
