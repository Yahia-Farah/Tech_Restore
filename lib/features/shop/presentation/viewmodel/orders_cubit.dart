import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/orders/get_all_orders_model.dart';
import '../../data/repositories/shop_repository.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final ShopRepository _repo;
  OrdersCubit(this._repo) : super(OrdersInitial());

  int currentApiPage = 0;
  int totalApiPages = 1;
  bool lastPage = false;
  List<OrderContent> orders = [];
  String? currentStatus;

  Future<void> getAllOrders({bool isRefresh = false}) async {
    if (isRefresh) {
      currentApiPage = 0;
      totalApiPages = 1;
      lastPage = false;
      orders.clear();
      currentStatus = null;
      emit(OrdersLoading());
    }
    if (lastPage) return;
    
    try {
      final result = await _repo.getAllOrders(page: currentApiPage);
      lastPage = result.last ?? false;
      totalApiPages = result.totalPages ?? 1;
      currentApiPage = (result.number ?? currentApiPage) + 1;
      orders.addAll(result.content ?? []);
      emit(OrdersLoaded(List<OrderContent>.from(orders), lastPage: lastPage));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> getOrdersByStatus(String status, {bool isRefresh = false}) async {
    if (isRefresh || currentStatus != status) {
      currentApiPage = 0;
      totalApiPages = 1;
      lastPage = false;
      orders.clear();
      currentStatus = status;
      emit(OrdersLoading());
    }
    if (lastPage) return;
    
    try {
      final result = await _repo.getOrdersByStatus(status, page: currentApiPage);
      lastPage = result.last ?? false;
      totalApiPages = result.totalPages ?? 1;
      currentApiPage = (result.number ?? currentApiPage) + 1;
      orders.addAll(result.content ?? []);
      emit(OrdersLoaded(List<OrderContent>.from(orders), lastPage: lastPage));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> getOrderDetails(String orderId) async {
    emit(OrderDetailsLoading());
    try {
      final order = await _repo.getOrderDetails(orderId);
      emit(OrderDetailsLoaded(order));
    } catch (e) {
      emit(OrderDetailsError(e.toString()));
    }
  }

  Future<void> acceptOrder(String orderId) async {
    emit(OrderActionLoading());
    try {
      await _repo.acceptOrder(orderId);
      emit(OrderActionSuccess('Order accepted successfully'));
      // Refresh orders list
      _refreshCurrentList();
    } catch (e) {
      emit(OrderActionError(e.toString()));
    }
  }

  Future<void> rejectOrder(String orderId) async {
    emit(OrderActionLoading());
    try {
      await _repo.rejectOrder(orderId);
      emit(OrderActionSuccess('Order rejected successfully'));
      // Refresh orders list
      _refreshCurrentList();
    } catch (e) {
      emit(OrderActionError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    emit(OrderActionLoading());
    try {
      await _repo.updateOrderStatus(orderId, status);
      emit(OrderActionSuccess('Order status updated successfully'));
      // Refresh orders list
      _refreshCurrentList();
    } catch (e) {
      emit(OrderActionError(e.toString()));
    }
  }

  void _refreshCurrentList() {
    if (currentStatus != null) {
      getOrdersByStatus(currentStatus!, isRefresh: true);
    } else {
      getAllOrders(isRefresh: true);
    }
  }

  // Helper methods for status management
  List<String> getAvailableStatuses() {
    return ['PENDING', 'CONFIRMED', 'PROCESSING', 'FINISHPROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED'];
  }

  String? getNextStatus(String currentStatus) {
    final statuses = ['PENDING', 'CONFIRMED', 'PROCESSING', 'FINISHPROCESSING', 'SHIPPED'];
    final currentIndex = statuses.indexOf(currentStatus.toUpperCase());
    if (currentIndex >= 0 && currentIndex < statuses.length - 1) {
      return statuses[currentIndex + 1];
    }
    return null;
  }

  bool canAcceptReject(String status) {
    return status == 'PENDING';
  }
}