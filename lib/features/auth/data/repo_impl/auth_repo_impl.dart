import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/data/models/forget_password_models/verify_email_request_model.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_request_model.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_response_model.dart';
import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_request_model.dart';
import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_response_model.dart';
import 'package:tech_restore/features/auth/data/models/signupmodels/sign_up_request_model.dart';
import 'package:tech_restore/features/auth/data/models/signupmodels/sign_up_response_model.dart';
import 'package:tech_restore/features/auth/domain/entites/delivery_entity.dart';
import 'package:tech_restore/features/auth/domain/entites/shop_entity.dart';
import 'package:tech_restore/features/auth/domain/entites/user_entity.dart';
import 'package:tech_restore/features/auth/domain/repo/auth_repo.dart';

import '../../domain/entites/assigner_entity.dart';
import '../../domain/responses/auth_response.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/forget_password_models/forget_password_request_model.dart';
import '../models/forget_password_models/reset_password_request_model.dart';
import '../models/signup_assigner_model/signup_assigner_request_model.dart';
import '../models/signup_delivery_models/signup_delivery_request_model.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDatasource;

  AuthRepositoryImpl(this._remoteDatasource);

  @override
  Future<SignUpResponseModel> signUp(UserEntity user) async {
    final request = SignUpRequest(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      phone: user.phone,
      password: user.password,
    );

    final response = await _remoteDatasource.signUp(request);
    return response;
  }

  @override
  Future<SignUpShopResponseModel> signUpShop(ShopEntity shop) async {
    final request = SignUpShopRequestModel(
      name: shop.name,
      email: shop.email,
      phone: shop.phone,
      password: shop.password,
      shopType: shop.shopType,
      description: shop.description,
      shopAddress: shop.shopAddress,
    );

    return _remoteDatasource.signUpShop(request);
  }

  @override
  Future<SignUpShopResponseModel> signUpDelivery(
    DeliveryEntity delivery,
  ) async {
    final request = SignupDeliveryRequestModel(
      name: delivery.firstName,
      address: delivery.address,
      email: delivery.email,
      phone: delivery.phone,
      password: delivery.password,
    );

    final response = await _remoteDatasource.signUpDelivery(request);
    return response;
  }

  @override
  Future<SignUpShopResponseModel> signUpAssigner(
    AssignerEntity delivery,
  ) async {
    final request = SignupAssignerRequestModel(
      name: delivery.firstName,
      department: delivery.department,
      email: delivery.email,
      phone: delivery.phone,
      password: delivery.password,
    );

    final response = await _remoteDatasource.signUpAssigner(request);
    return response;
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _remoteDatasource.login(request);
    return response;
  }

  @override
  Future<AuthResponse<String>> forgetPassword(String email) async {
    final model = ForgetPasswordRequestModel(email: email);
    return await _remoteDatasource.forgetPassword(model);
  }

  @override
  Future<AuthResponse<String>> resetPassword(
    String email,
    String newPassword,
    String code,
  ) async {
    final model = ResetPasswordRequestModel(
      email: email,
      newPassword: newPassword,
      otp: code,
      confirmPassword: newPassword,
    );
    return await _remoteDatasource.resetPassword(model);
  }

  @override
  Future<AuthResponse<String>> resendVerifyCode(String email) async {
    final model = ForgetPasswordRequestModel(email: email);
    return await _remoteDatasource.resendVerifyCode(model);
  }

  @override
  Future<AuthResponse<String>> verifyEmail(String email, String code) async {
    final model = VerifyEmailRequestModel(email: email, optCode: code);
    return await _remoteDatasource.verifyEmail(model);
  }

  @override
  Future<String> logout() {
    return _remoteDatasource.logout();
  }
}
