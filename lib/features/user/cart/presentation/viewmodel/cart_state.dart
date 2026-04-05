import '../../data/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartModel cart;
  CartLoaded(this.cart);
}

class CartItemAdding extends CartState {
  final String productId;
  CartItemAdding(this.productId);
}

class CartItemAdded extends CartState {
  final CartModel cart;
  CartItemAdded(this.cart);
}

class CartItemUpdating extends CartState {}

class CartItemUpdated extends CartState {
  final CartModel cart;
  CartItemUpdated(this.cart);
}

class CartItemRemoving extends CartState {
  final String itemId;
  CartItemRemoving(this.itemId);
}

class CartItemRemoved extends CartState {
  final CartModel cart;
  CartItemRemoved(this.cart);
}

class CartClearing extends CartState {}

class CartCleared extends CartState {}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}
