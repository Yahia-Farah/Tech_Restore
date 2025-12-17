import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../models/shop_response.dart';

@lazySingleton
class GetShopsRemoteDataSource {
  final ApiClient _apiClient;

  GetShopsRemoteDataSource(this._apiClient);

  Future<ShopListResponse> getShops() async {
    return await _apiClient.getShops();
  }
}
