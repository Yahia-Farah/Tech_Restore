import 'package:injectable/injectable.dart';
import '../data_source/cart_remote_datasource.dart';
import '../models/cart_model.dart';

abstract class CartRepository {
  Future<CartModel> getCart();
  Future<CartModel> addCartItem(String productId, int quantity);
  Future<CartModel> updateCartItem(
    String itemId,
    String productId,
    int quantity,
  );
  Future<CartModel> removeCartItem(String itemId);
  Future<void> clearCart();
}

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartRemoteDataSource _dataSource;

  CartRepositoryImpl(this._dataSource);

  @override
  Future<CartModel> getCart() => _dataSource.getCart();

  @override
  Future<CartModel> addCartItem(String productId, int quantity) =>
      _dataSource.addCartItem(productId, quantity);

  @override
  Future<CartModel> updateCartItem(
    String itemId,
    String productId,
    int quantity,
  ) => _dataSource.updateCartItem(itemId, productId, quantity);

  @override
  Future<CartModel> removeCartItem(String itemId) =>
      _dataSource.removeCartItem(itemId);

  @override
  Future<void> clearCart() => _dataSource.clearCart();
}
