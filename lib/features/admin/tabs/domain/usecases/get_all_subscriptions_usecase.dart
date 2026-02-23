import 'package:injectable/injectable.dart';
import '../../data/model/subscription-model/subscription_response.dart';
import '../repo/admin_repo.dart';

@injectable
class GetAllSubscriptionsUseCase {
  final AdminRepo _adminRepo;

  GetAllSubscriptionsUseCase(this._adminRepo);

  Future<SubscriptionResponse> call(int page) async {
    return await _adminRepo.getAllSubscriptions(page);
  }
}
