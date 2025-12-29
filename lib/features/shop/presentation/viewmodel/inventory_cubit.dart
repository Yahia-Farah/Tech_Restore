import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/products/product_model.dart';
import '../../data/repositories/shop_repository.dart';
import 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  final ShopRepository _repo;
  InventoryCubit(this._repo) : super(InventoryInitial());

  int currentApiPage = 0;
  bool lastPage = false;
  List<ProductModel> products = [];
  String? currentSearchQuery;

  // Stats
  int totalItems = 0;
  int lowStockCount = 0;
  int outOfStockCount = 0;
  double totalValue = 0.0;

  Future<void> searchInventory({String? query, bool isRefresh = false}) async {
    if (isRefresh) {
      currentApiPage = 0;
      lastPage = false;
      products.clear();
      emit(InventoryLoading());
    }
    if (lastPage && query == currentSearchQuery) return;

    currentSearchQuery = query;
    emit(InventoryLoading());
    try {
      final result = await _repo.searchInventory(query, currentApiPage);
      lastPage = result.last ?? false;
      products.addAll(result.content ?? []);
      emit(
        InventoryLoaded(List<ProductModel>.from(products), lastPage: lastPage),
      );
      if (!lastPage) {
        currentApiPage = (result.number ?? currentApiPage) + 1;
      }
    } catch (e) {
      emit(InventoryError(e.toString()));
    }
  }

  Future<void> loadInventoryStats() async {
    emit(InventoryStatsLoading());
    try {
      totalItems = await _repo.totalItemsInInventory();
      totalValue = await _repo.totalInventoryValue();

      // Get low stock and out of stock counts
      lowStockCount = await _repo.lowStockInInventory();
      outOfStockCount = await _repo.outOfStockInInventory();

      emit(
        InventoryStatsLoaded(
          totalItems: totalItems,
          lowStockCount: lowStockCount,
          outOfStockCount: outOfStockCount,
          totalValue: totalValue,
        ),
      );
    } catch (e) {
      emit(InventoryStatsError(e.toString()));
    }
  }
}
