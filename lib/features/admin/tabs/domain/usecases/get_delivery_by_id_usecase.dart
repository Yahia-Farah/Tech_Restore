import 'package:injectable/injectable.dart';
import '../../data/model/delivery-model/content_delivery_admin.dart';
import '../repo/admin_repo.dart';

@injectable
class GetDeliveryByIdUseCase {
  final AdminRepo _adminRepo;

  GetDeliveryByIdUseCase(this._adminRepo);

  Future<ContentDeliveryAdmin> call(String deliveryId) async {
    return await _adminRepo.getDeliveryById(deliveryId);
  }
}
