import 'package:injectable/injectable.dart';
import '../../manage-shops/data/repo/get_shops_repo.dart';

@injectable
class SuspendShopUseCase {
  final GetShopsRepository _repository;

  SuspendShopUseCase(this._repository);

  Future<String> call(String shopId) async {
    return await _repository.suspendShop(shopId);
  }
}
