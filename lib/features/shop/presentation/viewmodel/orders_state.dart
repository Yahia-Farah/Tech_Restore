import '../../data/models/orders/get_all_orders_model.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<OrderContent> orders;
  final bool lastPage;
  OrdersLoaded(this.orders, {this.lastPage = false});
}

class OrdersError extends OrdersState {
  final String msg;
  OrdersError(this.msg);
}

class OrderDetailsLoading extends OrdersState {}

class OrderDetailsLoaded extends OrdersState {
  final OrderContent order;
  OrderDetailsLoaded(this.order);
}

class OrderDetailsError extends OrdersState {
  final String msg;
  OrderDetailsError(this.msg);
}

class OrderActionLoading extends OrdersState {}

class OrderActionSuccess extends OrdersState {
  final String message;
  OrderActionSuccess(this.message);
}

class OrderActionError extends OrdersState {
  final String msg;
  OrderActionError(this.msg);
}