import 'package:injectable/injectable.dart';
import '../data_source/user_orders_remote_datasource.dart';
import '../models/get_orders_response_model.dart';

abstract class UserOrdersRepository {
  Future<GetOrdersResponseModel> getUserOrders();
  Future<void> cancelOrder(String orderId);
}

@Injectable(as: UserOrdersRepository)
class UserOrdersRepositoryImpl implements UserOrdersRepository {
  final UserOrdersRemoteDataSource _remoteDataSource;

  UserOrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<GetOrdersResponseModel> getUserOrders() async {
    return await _remoteDataSource.getUserOrders();
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _remoteDataSource.cancelOrder(orderId);
  }
}
