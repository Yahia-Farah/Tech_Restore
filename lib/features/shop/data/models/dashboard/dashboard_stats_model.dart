import 'package:json_annotation/json_annotation.dart';

part 'dashboard_stats_model.g.dart';

@JsonSerializable()
class DashboardStatsModel {
  final int totalSales;
  final int previousDaySales;
  final int difference;
  final bool increased;

  DashboardStatsModel({
    required this.totalSales,
    required this.previousDaySales,
    required this.difference,
    required this.increased,
  });

  factory DashboardStatsModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardStatsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DashboardStatsModelToJson(this);
}
