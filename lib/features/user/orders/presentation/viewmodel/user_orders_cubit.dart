import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/user_orders_repository.dart';
import '../../data/models/order_model.dart';
import 'user_orders_state.dart';

@injectable
class UserOrdersCubit extends Cubit<UserOrdersState> {
  final UserOrdersRepository _repository;
  List<OrderModel> _orders = [];

  UserOrdersCubit(this._repository) : super(UserOrdersInitial());

  List<OrderModel> get orders => _orders;

  Future<void> getUserOrders() async {
    emit(UserOrdersLoading());
    try {
      final response = await _repository.getUserOrders();
      _orders = response.content;
      emit(UserOrdersLoaded(_orders));
    } catch (e) {
      emit(UserOrdersError(e.toString()));
    }
  }

  Future<void> cancelOrder(String orderId) async {
    emit(UserOrderCancelLoading(orderId));
    try {
      await _repository.cancelOrder(orderId);

      // Update local orders list
      _orders =
          _orders.map((order) {
            if (order.id == orderId) {
              return OrderModel(
                id: order.id,
                userId: order.userId,
                firstName: order.firstName,
                lastName: order.lastName,
                phoneNumber: order.phoneNumber,
                deliveryAddressId: order.deliveryAddressId,
                totalPrice: order.totalPrice,
                status: 'CANCELLED',
                paymentMethod: order.paymentMethod,
                createdAt: order.createdAt,
                paymentId: order.paymentId,
                orderItems: order.orderItems,
              );
            }
            return order;
          }).toList();

      emit(UserOrderCancelSuccess(orderId));
      emit(UserOrdersLoaded(_orders));
    } catch (e) {
      emit(UserOrderCancelError(e.toString()));
      emit(UserOrdersLoaded(_orders));
    }
  }

  OrderModel? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }
}
