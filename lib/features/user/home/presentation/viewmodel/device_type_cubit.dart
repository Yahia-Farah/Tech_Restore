import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/home_repository.dart';
import 'device_type_state.dart';

@injectable
class DeviceTypeCubit extends Cubit<DeviceTypeState> {
  final HomeRepository _repository;

  DeviceTypeCubit(this._repository) : super(DeviceTypeInitial());

  Future<void> loadCategories() async {
    emit(DeviceTypeLoading());
    try {
      final response = await _repository.getCategoriesPageable(
        page: 0,
        size: 100,
      );
      print('Categories loaded successfully: ${response.content.length} items');
      emit(DeviceTypeLoaded(response.content));
    } catch (e, stackTrace) {
      print('Error loading categories: $e');
      print('Stack trace: $stackTrace');
      emit(DeviceTypeError('Unable to load categories from server'));
    }
  }
}
