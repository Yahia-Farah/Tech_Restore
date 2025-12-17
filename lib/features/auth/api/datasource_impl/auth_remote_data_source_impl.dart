import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_request_model.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_response_model.dart';
import 'package:tech_restore/features/auth/data/models/signup_shop_models/sign_up_shop_response_model.dart';
import '../../../../core/api/client/api_client.dart';
import '../../../../core/errors/api_error_result.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/models/forget_password_models/forget_password_request_model.dart';
import '../../data/models/forget_password_models/reset_password_request_model.dart';
import '../../data/models/forget_password_models/verify_email_request_model.dart';
import '../../data/models/signup_assigner_model/signup_assigner_request_model.dart';
import '../../data/models/signup_delivery_models/signup_delivery_request_model.dart';
import '../../data/models/signup_shop_models/sign_up_shop_request_model.dart';
import '../../data/models/signupmodels/sign_up_request_model.dart';
import '../../data/models/signupmodels/sign_up_response_model.dart';
import '../../domain/responses/auth_response.dart';
import '../../domain/services/auth_services.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDatasourceImpl(this._apiClient);

  @override
  Future<SignUpResponseModel> signUp(SignUpRequest request) async {
    try {
      final result = await _apiClient.signUp(request);
      return result;
    } on DioException catch (e) {
      final apiMessage = ApiErrorHandler.extractMessage(e);
      throw Exception(apiMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SignUpShopResponseModel> signUpShop(
    SignUpShopRequestModel request,
  ) async {
    try {
      final result = await _apiClient.signUpShop(request);
      return result;
    } on DioException catch (e) {
      final apiMessage = ApiErrorHandler.extractMessage(e);
      throw Exception(apiMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SignUpShopResponseModel> signUpDelivery(
    SignupDeliveryRequestModel request,
  ) async {
    try {
      final result = await _apiClient.signUpDelivery(request);
      return result;
    } on DioException catch (e) {
      final apiMessage = ApiErrorHandler.extractMessage(e);
      throw Exception(apiMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<SignUpShopResponseModel> signUpAssigner(
    SignupAssignerRequestModel request,
  ) async {
    try {
      final result = await _apiClient.signUpAssigner(request);
      return result;
    } on DioException catch (e) {
      final apiMessage = ApiErrorHandler.extractMessage(e);
      throw Exception(apiMessage);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final httpResponse = await _apiClient.login(request);

      _extractAndSaveRefreshToken(httpResponse.response);

      return httpResponse.data;
    } on DioException catch (e) {
      final apiMessage = ApiErrorHandler.extractMessage(e);
      throw Exception(apiMessage);
    }
  }

  @override
  Future<AuthResponse<String>> forgetPassword(
    ForgetPasswordRequestModel forgetPasswordRequestModel,
  ) async {
    try {
      final result = await _apiClient.forgetPassword(
        forgetPasswordRequestModel,
      );
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = ApiErrorHandler.extractMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) async {
    try {
      final result = await _apiClient.resetPassword(resetPasswordRequestModel);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = ApiErrorHandler.extractMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> resendVerifyCode(
    ForgetPasswordRequestModel verifyCodeRequestModel,
  ) async {
    try {
      final result = await _apiClient.resendCode(verifyCodeRequestModel);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = ApiErrorHandler.extractMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<AuthResponse<String>> verifyEmail(
    VerifyEmailRequestModel verifyEmailRequestModel,
  ) async {
    try {
      final result = await _apiClient.verifyEmail(verifyEmailRequestModel);
      return AuthResponse.success(result);
    } on DioException catch (e) {
      String apiMessage = ApiErrorHandler.extractMessage(e);
      return AuthResponse.error(apiMessage);
    } catch (e) {
      return AuthResponse.error(e.toString());
    }
  }

  @override
  Future<String> logout() async {
    return await _apiClient.logout();
  }

  void _extractAndSaveRefreshToken(Response response) async {
    final cookies = response.headers['set-cookie'];
    if (cookies == null) return;

    for (final cookie in cookies) {
      if (cookie.startsWith("refresh_token=")) {
        final token = cookie.split("refresh_token=").last.split(";").first;
        await AuthService.saveRefreshToken(token);
        break;
      }
    }
  }
}
