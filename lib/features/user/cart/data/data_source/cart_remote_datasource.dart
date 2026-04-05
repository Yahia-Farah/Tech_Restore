import 'package:injectable/injectable.dart';
import '../../../../../core/api/client/api_client.dart';
import '../models/cart_model.dart';
import '../models/add_cart_item_request.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart({int page = 0, int size = 20});
  Future<CartModel> addCartItem(String productId, int quantity);
  Future<CartModel> updateCartItem(
    String itemId,
    String productId,
    int quantity,
  );
  Future<CartModel> removeCartItem(String itemId);
  Future<void> clearCart();
}

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiClient _apiClient;

  CartRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CartModel> getCart({int page = 0, int size = 20}) async {
    return await _apiClient.getCart(page, size);
  }

  @override
  Future<CartModel> addCartItem(String productId, int quantity) async {
    return await _apiClient.addCartItem(
      AddCartItemRequest(productId: productId, quantity: quantity),
      0,
      20,
    );
  }

  @override
  Future<CartModel> updateCartItem(
    String itemId,
    String productId,
    int quantity,
  ) async {
    return await _apiClient.updateCartItem(
      itemId,
      AddCartItemRequest(productId: productId, quantity: quantity),
      0,
      20,
    );
  }

  @override
  Future<CartModel> removeCartItem(String itemId) async {
    return await _apiClient.removeCartItem(itemId, 0, 20);
  }

  @override
  Future<void> clearCart() async {
    await _apiClient.clearCart();
  }
}
