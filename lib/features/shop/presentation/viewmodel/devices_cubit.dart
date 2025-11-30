import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/products/product_model.dart';
import '../../data/models/products/get_all_category_model.dart';
import '../../data/models/products/add_product_request.dart';
import '../../data/repositories/shop_repository.dart';
import 'devices_state.dart';

class DevicesCubit extends Cubit<DevicesState> {
  final ShopRepository _repo;
  DevicesCubit(this._repo) : super(DevicesInitial());

  int currentApiPage = 0;
  int totalApiPages = 1;
  bool lastPage = false;
  List<ProductModel> devices = [];
  List<Content> categories = [];

  Future<void> getAllDevices({bool isRefresh = false}) async {
    if (isRefresh) {
      currentApiPage = 0;
      totalApiPages = 1;
      lastPage = false;
      devices.clear();
      emit(DevicesLoading());
    }
    if (lastPage) return;
    emit(DevicesLoading());
    try {
      final result = await _repo.getAllProducts(page: currentApiPage);
      lastPage = result.last ?? false;
      totalApiPages = result.totalPages ?? 1;
      currentApiPage = (result.number ?? currentApiPage) + 1;
      devices.addAll(result.content ?? []);
      emit(DevicesLoaded(List<ProductModel>.from(devices), lastPage: lastPage));
    } catch (e) {
      emit(DevicesError(e.toString()));
    }
  }

  Future<void> addDevice(AddProductRequest req) async {
    emit(DeviceAddLoading());
    try {
      await _repo.addProducts(req);
      emit(DeviceAddSuccess('Device added'));
      getAllDevices(isRefresh:true);
    } catch (e) {
      emit(DeviceAddError(e.toString()));
    }
  }

  Future<void> updateDevice(String productId, AddProductRequest req) async {
    emit(DeviceAddLoading());
    try {
      final updatedProduct = await _repo.updateProduct(productId, req);
      // Find and update the device in place to preserve its position
      final index = devices.indexWhere((d) => d.id == productId);
      if (index != -1) {
        devices[index] = updatedProduct;
        emit(DevicesLoaded(List<ProductModel>.from(devices), lastPage: lastPage));
      } else {
        // If not found, refresh the list
        getAllDevices(isRefresh: true);
      }
      emit(DeviceAddSuccess('Device updated'));
    } catch (e) {
      emit(DeviceAddError(e.toString()));
    }
  }

  Future<void> deleteDevice(String productId) async {
    emit(DeviceAddLoading());
    try {
      await _repo.deleteProducts(productId);
      emit(DeviceAddSuccess('Device deleted'));
      getAllDevices(isRefresh:true);
    } catch (e) {
      emit(DeviceAddError(e.toString()));
    }
  }

  Future<void> getCategories() async {
    try {
      final result = await _repo.getAllCategory(page: 0);
      categories = result.content ?? [];
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(DevicesError(e.toString()));
    }
  }
}
