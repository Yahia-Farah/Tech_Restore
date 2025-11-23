import 'package:injectable/injectable.dart';
import '../datasource/get_user_remote_data_source_impl.dart';
import '../models/user_model_response.dart';

@lazySingleton
class GetUserRepository {
  final GetUserRemoteDataSource _remoteDataSource;

  GetUserRepository(this._remoteDataSource);

  Future<UserListResponse> getUsers() async {
    return await _remoteDataSource.getUsers();
  }
}

