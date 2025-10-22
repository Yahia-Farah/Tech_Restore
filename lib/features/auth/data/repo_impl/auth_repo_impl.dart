import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_request_model.dart';
import 'package:tech_restore/features/auth/data/models/login_models/login_response_model.dart';
import 'package:tech_restore/features/auth/data/models/signupmodels/sign_up_request_model.dart';
import 'package:tech_restore/features/auth/data/models/signupmodels/sign_up_response_model.dart';
import 'package:tech_restore/features/auth/domain/entites/user_entity.dart';
import 'package:tech_restore/features/auth/domain/repo/auth_repo.dart';

import '../datasource/auth_remote_data_source.dart';

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
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    final response = await _remoteDatasource.login(request);
    return response;
  }
}
