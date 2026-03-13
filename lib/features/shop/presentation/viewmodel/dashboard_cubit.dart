import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/shop/data/models/dashboard/date_range_request.dart';
import 'package:tech_restore/features/shop/data/repositories/shop_repository.dart';
import 'package:tech_restore/features/shop/data/models/dashboard/dashboard_stats_model.dart';
import 'dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<DashboardState> {
  final ShopRepository _repository;

  DashboardCubit(this._repository) : super(DashboardInitial());

  Future<void> loadDashboardData({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    emit(DashboardLoading());

    try {
      // Prepare date range request
      DateRangeRequest? dateRangeRequest;
      if (startDate != null && endDate != null) {
        dateRangeRequest = DateRangeRequest(
          startDate: startDate.toIso8601String(),
          endDate: endDate.toIso8601String(),
        );
      }

      // Fetch KPI data
      final results = await Future.wait([
        _repository.getDashboardRepairsTotal(),
        _repository.getDashboardSalesTotal(
          dateRangeRequest ?? DateRangeRequest(),
        ),
        _repository.getDashboardOrdersTotal(
          dateRangeRequest ?? DateRangeRequest(),
        ),
        _repository.getDashboardSalesStats(),
        _repository.getDashboardRepairsStats(),
      ]);

      // Fetch chart data for last 4 days
      final now = DateTime.now();
      final List<Future<DashboardStatsModel>> salesChartFutures = [];
      final List<Future<DashboardStatsModel>> repairsChartFutures = [];

      for (int i = 3; i >= 0; i--) {
        salesChartFutures.add(_repository.getDashboardSalesStats());
        repairsChartFutures.add(_repository.getDashboardRepairsStats());
      }

      final salesChartData = await Future.wait(salesChartFutures);
      final repairsChartData = await Future.wait(repairsChartFutures);

      emit(
        DashboardLoaded(
          totalRepairs: results[0] as int,
          totalSales: results[1] as int,
          totalOrders: results[2] as int,
          salesStats: results[3] as DashboardStatsModel,
          repairsStats: results[4] as DashboardStatsModel,
          salesChartData: salesChartData,
          repairsChartData: repairsChartData,
        ),
      );
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> refreshDashboard({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await loadDashboardData(startDate: startDate, endDate: endDate);
  }
}
