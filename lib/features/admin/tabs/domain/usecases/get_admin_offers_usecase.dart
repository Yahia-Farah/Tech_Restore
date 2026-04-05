import 'package:injectable/injectable.dart';
import '../../manage-offers/data/models/offer_page_model.dart';
import '../repo/admin_repo.dart';

@injectable
class GetAdminOffersUseCase {
  final AdminRepo _adminRepo;

  GetAdminOffersUseCase(this._adminRepo);

  Future<OfferPageModel> call(int page) async {
    return await _adminRepo.getAdminOffers(page);
  }
}
