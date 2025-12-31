import 'package:equatable/equatable.dart';
import '../../data/models/order_model.dart';

abstract class UserOrdersState extends Equatable {
  const UserOrdersState();

  @override
  List<Object?> get props => [];
}

class UserOrdersInitial extends UserOrdersState {}

class UserOrdersLoading extends UserOrdersState {}

class UserOrdersLoaded extends UserOrdersState {
  final List<OrderModel> orders;

  const UserOrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class UserOrdersError extends UserOrdersState {
  final String message;

  const UserOrdersError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserOrderCancelLoading extends UserOrdersState {
  final String orderId;

  const UserOrderCancelLoading(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class UserOrderCancelSuccess extends UserOrdersState {
  final String orderId;

  const UserOrderCancelSuccess(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

class UserOrderCancelError extends UserOrdersState {
  final String message;

  const UserOrderCancelError(this.message);

  @override
  List<Object?> get props => [message];
}
