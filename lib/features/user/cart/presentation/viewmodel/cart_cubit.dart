import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/cart_repository.dart';
import '../../data/models/cart_model.dart';
import 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final CartRepository _repository;
  CartModel? _cart;

  CartCubit(this._repository) : super(CartInitial());

  CartModel? get cart => _cart;

  Future<void> loadCart() async {
    emit(CartLoading());
    try {
      _cart = await _repository.getCart();
      emit(CartLoaded(_cart!));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addItem(String productId, int quantity) async {
    emit(CartItemAdding(productId));
    try {
      _cart = await _repository.addCartItem(productId, quantity);
      emit(CartItemAdded(_cart!));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateItem(String itemId, String productId, int quantity) async {
    emit(CartItemUpdating());
    try {
      _cart = await _repository.updateCartItem(itemId, productId, quantity);
      emit(CartItemUpdated(_cart!));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> removeItem(String itemId) async {
    emit(CartItemRemoving(itemId));
    try {
      _cart = await _repository.removeCartItem(itemId);
      emit(CartItemRemoved(_cart!));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> clearCart() async {
    emit(CartClearing());
    try {
      await _repository.clearCart();
      _cart = null;
      emit(CartCleared());
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
