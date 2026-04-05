import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_all_subscriptions_usecase.dart';
import '../../../domain/usecases/get_pending_cash_subscriptions_usecase.dart';
import 'states/subscription_states.dart';

@injectable
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetAllSubscriptionsUseCase _getAllSubscriptionsUseCase;
  final GetPendingCashSubscriptionsUseCase _getPendingCashSubscriptionsUseCase;
  int _currentPage = 0;
  String _currentFilter = 'all';

  SubscriptionCubit(
    this._getAllSubscriptionsUseCase,
    this._getPendingCashSubscriptionsUseCase,
  ) : super(SubscriptionInitial());

  Future<void> getSubscriptions(int page, String filter) async {
    _currentPage = page;
    _currentFilter = filter;
    emit(SubscriptionLoading());
    try {
      if (filter == 'pending_cash') {
        final subscriptions = await _getPendingCashSubscriptionsUseCase(page);
        emit(SubscriptionLoaded(subscriptions));
      } else {
        final subscriptions = await _getAllSubscriptionsUseCase(page);
        emit(SubscriptionLoaded(subscriptions));
      }
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  void refreshSubscriptions() {
    getSubscriptions(_currentPage, _currentFilter);
  }
}
