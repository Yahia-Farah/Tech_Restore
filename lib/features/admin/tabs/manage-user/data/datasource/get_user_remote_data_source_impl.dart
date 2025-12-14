import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../models/user_model_response.dart';

@lazySingleton
class GetUserRemoteDataSource {
  final ApiClient _apiClient;

  GetUserRemoteDataSource(this._apiClient);

  Future<UserListResponse> getUsers() async {
    return await _apiClient.getUsers();
  }
}



