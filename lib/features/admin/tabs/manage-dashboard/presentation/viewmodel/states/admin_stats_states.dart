import '../../../../data/model/admin-states/admin_states_response.dart';

abstract class AdminStatsState {}

class AdminStatsInitial extends AdminStatsState {}

class AdminStatsLoading extends AdminStatsState {}

class AdminStatsLoaded extends AdminStatsState {
  final AdminStatesResponse stats;
  AdminStatsLoaded(this.stats);
}

class AdminStatsError extends AdminStatsState {
  final String message;
  AdminStatsError(this.message);
}
