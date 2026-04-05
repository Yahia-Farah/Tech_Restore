import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_admin_offers_usecase.dart';
import 'states/admin_offers_states.dart';

@injectable
class AdminOffersCubit extends Cubit<AdminOffersState> {
  final GetAdminOffersUseCase _getAdminOffersUseCase;
  int _currentPage = 0;

  AdminOffersCubit(this._getAdminOffersUseCase) : super(AdminOffersInitial());

  Future<void> getAdminOffers(int page) async {
    _currentPage = page;
    emit(AdminOffersLoading());
    try {
      final offers = await _getAdminOffersUseCase(page);
      emit(AdminOffersLoaded(offers));
    } catch (e) {
      emit(AdminOffersError(e.toString()));
    }
  }

  void refreshOffers() {
    getAdminOffers(_currentPage);
  }
}
