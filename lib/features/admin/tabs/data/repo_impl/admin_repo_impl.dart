import 'package:injectable/injectable.dart';
import '../../domain/repo/admin_repo.dart';
import '../../data/datasource/admin_remote_datasource.dart';
import '../model/admin-states/admin_states_response.dart';

@Injectable(as: AdminRepo)
class AdminRepoImpl implements AdminRepo {
  final AdminRemoteDataSource _remoteDataSource;

  AdminRepoImpl(this._remoteDataSource);

  @override
  Future<AdminStatesResponse> getAdminStats() async {
    return await _remoteDataSource.getAdminStats();
  }
}
