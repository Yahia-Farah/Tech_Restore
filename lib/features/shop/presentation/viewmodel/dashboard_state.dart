import 'package:tech_restore/features/shop/data/models/dashboard/dashboard_stats_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int totalRepairs;
  final int totalSales;
  final int totalOrders;
  final DashboardStatsModel salesStats;
  final DashboardStatsModel repairsStats;
  final List<DashboardStatsModel> salesChartData;
  final List<DashboardStatsModel> repairsChartData;

  DashboardLoaded({
    required this.totalRepairs,
    required this.totalSales,
    required this.totalOrders,
    required this.salesStats,
    required this.repairsStats,
    required this.salesChartData,
    required this.repairsChartData,
  });
}

class DashboardError extends DashboardState {
  final String message;

  DashboardError(this.message);
}
