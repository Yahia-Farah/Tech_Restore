import 'package:injectable/injectable.dart';
import '../datasource/get_shops_data_source_impl.dart';
import '../models/shop_response.dart';

@lazySingleton
class GetShopsRepository {
  final GetShopsRemoteDataSource _remoteDataSource;

  GetShopsRepository(this._remoteDataSource);

  Future<ShopListResponse> getShops() async {
    return await _remoteDataSource.getShops();
  }
}


