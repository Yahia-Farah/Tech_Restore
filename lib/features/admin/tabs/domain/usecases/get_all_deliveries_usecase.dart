import 'package:injectable/injectable.dart';
import '../../data/model/delivery-model/delivery_admin_response.dart';
import '../repo/admin_repo.dart';

@injectable
class GetAllDeliveriesUseCase {
  final AdminRepo _adminRepo;

  GetAllDeliveriesUseCase(this._adminRepo);

  Future<DeliveryAdminResponse> call(int page) async {
    return await _adminRepo.getAllDeliveries(page);
  }
}


