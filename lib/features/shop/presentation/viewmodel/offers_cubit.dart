import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/offers/get_all_offers_model.dart';
import '../../data/models/offers/offer_request.dart';
import '../../data/repositories/shop_repository.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  final ShopRepository _repo;
  OffersCubit(this._repo) : super(OffersInitial());

  int currentApiPage = 0;
  int totalApiPages = 1;
  bool lastPage = false;
  List<Content> offers = [];

  Future<void> getAllOffers({bool isRefresh = false}) async {
    if (isRefresh) {
      currentApiPage = 0;
      totalApiPages = 1;
      lastPage = false;
      offers.clear();
      emit(OffersLoading());
    }
    if (lastPage) return;
    emit(OffersLoading());
    try {
      final result = await _repo.getAllOffers(page: currentApiPage);
      lastPage = result.last ?? false;
      totalApiPages = result.totalPages ?? 1;
      currentApiPage = (result.number ?? currentApiPage) + 1; // next page
      offers.addAll(result.content ?? []);
      emit(OffersLoaded(List<Content>.from(offers), lastPage: lastPage));
    } catch (e) {
      emit(OffersError(e.toString()));
    }
  }

  Future<void> addOffer(OfferRequest req) async {
    emit(OffersActionLoading());
    try {
      await _repo.addOffer(req);
      emit(OffersActionSuccess('Offer added'));
      getAllOffers(isRefresh: true);
    } catch (e) {
      emit(OffersActionError(e.toString()));
    }
  }

  Future<void> updateOffer(String offerId, OfferRequest req) async {
    emit(OffersActionLoading());
    try {
      await _repo.updateOffer(offerId, req);
      emit(OffersActionSuccess('Offer updated'));
      getAllOffers(isRefresh: true);
    } catch (e) {
      emit(OffersActionError(e.toString()));
    }
  }

  Future<void> deleteOffer(String offerId) async {
    emit(OffersActionLoading());
    try {
      await _repo.deleteOffer(offerId);
      emit(OffersActionSuccess('Offer deleted'));
      getAllOffers(isRefresh: true);
    } catch (e) {
      emit(OffersActionError(e.toString()));
    }
  }
}
