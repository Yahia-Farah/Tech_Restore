import '../../../../data/model/delivery-model/content_delivery_admin.dart';
import '../../../../data/model/delivery-model/delivery_admin_response.dart';

abstract class DeliveriesState {}

class DeliveriesInitial extends DeliveriesState {}

class DeliveriesLoading extends DeliveriesState {}

class DeliveriesLoaded extends DeliveriesState {
  final DeliveryAdminResponse deliveries;

  DeliveriesLoaded(this.deliveries);
}

class DeliveryByIdLoaded extends DeliveriesState {
  final ContentDeliveryAdmin delivery;

  DeliveryByIdLoaded(this.delivery);
}

class DeliveriesError extends DeliveriesState {
  final String message;

  DeliveriesError(this.message);
}
