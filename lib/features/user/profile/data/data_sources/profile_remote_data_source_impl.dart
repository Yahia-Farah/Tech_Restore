import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../models/profile_response.dart';

@lazySingleton
class ProfileRemoteDataSource {
  final ApiClient _apiClient;

  ProfileRemoteDataSource(this._apiClient);

  Future<ProfileResponse> getProfile() async {
    return await _apiClient.getProfile();
  }
}
