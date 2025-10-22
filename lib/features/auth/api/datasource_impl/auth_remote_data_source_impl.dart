import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_request_model.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_response_model.dart';
import '../../../../core/api/client/api_client.dart';
import '../../../../core/errors/api_error_result.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../data/models/signupmodels/sign_up_request_model.dart';
import '../../data/models/signupmodels/sign_up_response_model.dart';


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
  Future<LoginResponseModel> login(LoginRequestModel request) async{
    try{
      final response = await _apiClient.login(request);
      return response;
    }on DioException catch(e){
      final apiMessage = ApiErrorHandler.extractMessage(e);
      throw Exception(apiMessage);
    }
  }


}