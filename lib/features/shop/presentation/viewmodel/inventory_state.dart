import '../../data/models/products/product_model.dart';

abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<ProductModel> products;
  final bool lastPage;
  InventoryLoaded(this.products, {required this.lastPage});
}

class InventoryError extends InventoryState {
  final String msg;
  InventoryError(this.msg);
}

class InventoryStatsLoading extends InventoryState {}

class InventoryStatsLoaded extends InventoryState {
  final int totalItems;
  final int lowStockCount;
  final int outOfStockCount;
  final double totalValue;
  InventoryStatsLoaded({
    required this.totalItems,
    required this.lowStockCount,
    required this.outOfStockCount,
    required this.totalValue,
  });
}

class InventoryStatsError extends InventoryState {
  final String msg;
  InventoryStatsError(this.msg);
}








