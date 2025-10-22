import 'package:injectable/injectable.dart';

import '../../domain/entites/user_entity.dart';
import '../../domain/repo/auth_repo.dart';
import '../datasource/auth_remote_data_source.dart';
import '../models/signupmodels/sign_up_request_model.dart';
import '../models/signupmodels/sign_up_response_model.dart';


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
}
