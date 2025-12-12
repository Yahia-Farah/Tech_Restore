import '../../data/models/products/product_model.dart';
import '../../data/models/products/get_all_category_model.dart';

abstract class DevicesState {}

class DevicesInitial extends DevicesState {}
class DevicesLoading extends DevicesState {}
class DevicesLoaded extends DevicesState {
  final List<ProductModel> devices;
  final bool lastPage;
  DevicesLoaded(this.devices, {required this.lastPage});
}
class DevicesError extends DevicesState {
  final String msg;
  DevicesError(this.msg);
}
class DeviceAddLoading extends DevicesState {}
class DeviceAddSuccess extends DevicesState {
  final String msg;
  DeviceAddSuccess(this.msg);
}
class DeviceAddError extends DevicesState {
  final String msg;
  DeviceAddError(this.msg);
}
class CategoriesLoaded extends DevicesState {
  final List<Content> categories;
  CategoriesLoaded(this.categories);
}
