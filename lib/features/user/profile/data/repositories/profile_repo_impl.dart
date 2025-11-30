import 'package:injectable/injectable.dart';
import '../data_sources/profile_remote_data_source_impl.dart';
import '../models/edit_profile_request.dart';
import '../models/profile_response.dart';

@lazySingleton
class ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepository(this._remoteDataSource);

  Future<ProfileResponse> getProfile() async {
    return await _remoteDataSource.getProfile();
  }

  Future<ProfileResponse> editProfile(EditProfileRequest request) async {
    return await _remoteDataSource.editProfile(request);
  }
}
