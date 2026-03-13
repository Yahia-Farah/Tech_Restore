// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_stats_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardStatsModel _$DashboardStatsModelFromJson(Map<String, dynamic> json) =>
    DashboardStatsModel(
      totalSales: (json['totalSales'] as num).toInt(),
      previousDaySales: (json['previousDaySales'] as num).toInt(),
      difference: (json['difference'] as num).toInt(),
      increased: json['increased'] as bool,
    );

Map<String, dynamic> _$DashboardStatsModelToJson(
        DashboardStatsModel instance) =>
    <String, dynamic>{
      'totalSales': instance.totalSales,
      'previousDaySales': instance.previousDaySales,
      'difference': instance.difference,
      'increased': instance.increased,
    };
