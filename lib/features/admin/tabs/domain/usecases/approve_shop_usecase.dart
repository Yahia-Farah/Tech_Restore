import 'package:injectable/injectable.dart';
import '../../manage-shops/data/repo/get_shops_repo.dart';

@injectable
class ApproveShopUseCase {
  final GetShopsRepository _repository;

  ApproveShopUseCase(this._repository);

  Future<String> call(String shopId) async {
    return await _repository.approveShop(shopId);
  }
}

