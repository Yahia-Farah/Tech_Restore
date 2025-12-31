import 'package:injectable/injectable.dart';
import '../../../../../core/api/client/api_client.dart';
import '../models/get_orders_response_model.dart';

abstract class UserOrdersRemoteDataSource {
  Future<GetOrdersResponseModel> getUserOrders();
  Future<void> cancelOrder(String orderId);
}

@Injectable(as: UserOrdersRemoteDataSource)
class UserOrdersRemoteDataSourceImpl implements UserOrdersRemoteDataSource {
  final ApiClient _apiClient;

  UserOrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<GetOrdersResponseModel> getUserOrders() async {
    final response = await _apiClient.getUserOrders();
    return GetOrdersResponseModel.fromJson(response);
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _apiClient.cancelUserOrder(orderId);
  }
}
