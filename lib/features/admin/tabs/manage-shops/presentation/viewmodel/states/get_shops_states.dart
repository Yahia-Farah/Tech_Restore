import '../../../data/models/shop_response.dart';

abstract class GetShopsState {}

class GetShopsInitial extends GetShopsState {}

class GetShopsLoading extends GetShopsState {}

class GetShopsLoaded extends GetShopsState {
  final ShopListResponse shops;
  GetShopsLoaded(this.shops);
}

class GetShopsError extends GetShopsState {
  final String message;
  GetShopsError(this.message);
}

class ShopApproved extends GetShopsState {
  final String message;
  ShopApproved(this.message);
}

class ShopSuspended extends GetShopsState {
  final String message;
  ShopSuspended(this.message);
}



