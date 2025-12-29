import '../../data/models/offers/get_all_offers_model.dart';

abstract class OffersState {}

class OffersInitial extends OffersState {}

class OffersLoading extends OffersState {}

class OffersLoaded extends OffersState {
  final List<Content> offers;
  final bool lastPage;
  OffersLoaded(this.offers, {this.lastPage = false});
}

class OffersError extends OffersState {
  final String msg;
  OffersError(this.msg);
}

class OffersActionLoading extends OffersState {}

class OffersActionSuccess extends OffersState {
  final String message;
  OffersActionSuccess(this.message);
}

class OffersActionError extends OffersState {
  final String msg;
  OffersActionError(this.msg);
}
