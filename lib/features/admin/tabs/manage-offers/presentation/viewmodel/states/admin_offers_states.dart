import '../../../data/models/offer_page_model.dart';

abstract class AdminOffersState {}

class AdminOffersInitial extends AdminOffersState {}

class AdminOffersLoading extends AdminOffersState {}

class AdminOffersLoaded extends AdminOffersState {
  final OfferPageModel offers;

  AdminOffersLoaded(this.offers);
}

class AdminOffersError extends AdminOffersState {
  final String message;

  AdminOffersError(this.message);
}
