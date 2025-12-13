import 'package:injectable/injectable.dart';
import '../repo/admin_repo.dart';
import '../../data/model/admin-states/admin_states_response.dart';

@injectable
class AdminStatesUseCase {
  final AdminRepo _adminRepo;

  AdminStatesUseCase(this._adminRepo);

  Future<AdminStatesResponse> call() async {
    return await _adminRepo.getAdminStats();
  }
}