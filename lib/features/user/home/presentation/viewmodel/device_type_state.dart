import '../../data/models/category_model.dart';

abstract class DeviceTypeState {}

class DeviceTypeInitial extends DeviceTypeState {}

class DeviceTypeLoading extends DeviceTypeState {}

class DeviceTypeLoaded extends DeviceTypeState {
  final List<CategoryModel> categories;

  DeviceTypeLoaded(this.categories);
}

class DeviceTypeError extends DeviceTypeState {
  final String message;

  DeviceTypeError(this.message);
}
