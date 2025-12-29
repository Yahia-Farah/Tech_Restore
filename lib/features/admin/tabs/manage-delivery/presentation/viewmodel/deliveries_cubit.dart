import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/get_all_deliveries_usecase.dart';
import '../../../domain/usecases/get_delivery_by_id_usecase.dart';
import '../viewmodel/states/deliveries_states.dart';

@injectable
class DeliveriesCubit extends Cubit<DeliveriesState> {
  final GetAllDeliveriesUseCase _getAllDeliveriesUseCase;
  final GetDeliveryByIdUseCase _getDeliveryByIdUseCase;
  int _currentPage = 0;

  DeliveriesCubit(this._getAllDeliveriesUseCase, this._getDeliveryByIdUseCase)
    : super(DeliveriesInitial());

  Future<void> getAllDeliveries(int page) async {
    _currentPage = page;
    emit(DeliveriesLoading());
    try {
      final deliveries = await _getAllDeliveriesUseCase(page);
      emit(DeliveriesLoaded(deliveries));
    } catch (e) {
      emit(DeliveriesError(e.toString()));
    }
  }

  Future<void> getDeliveryById(String deliveryId) async {
    emit(DeliveriesLoading());
    try {
      final delivery = await _getDeliveryByIdUseCase(deliveryId);
      emit(DeliveryByIdLoaded(delivery));
    } catch (e) {
      emit(DeliveriesError(e.toString()));
    }
  }

  void refreshDeliveries() {
    getAllDeliveries(_currentPage);
  }
}

