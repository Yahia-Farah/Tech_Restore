import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/admin_states_usecase.dart';
import '../viewmodel/states/admin_stats_states.dart';

@injectable
class AdminStatsCubit extends Cubit<AdminStatsState> {
  final AdminStatesUseCase _useCase;

  AdminStatsCubit(this._useCase) : super(AdminStatsInitial());

  Future<void> getAdminStats() async {
    emit(AdminStatsLoading());
    try {
      final stats = await _useCase();
      emit(AdminStatsLoaded(stats));
    } catch (e) {
      emit(AdminStatsError(e.toString()));
    }
  }
}

