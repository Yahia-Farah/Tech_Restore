// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_sort_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestSortInfo _$RepairRequestSortInfoFromJson(
        Map<String, dynamic> json) =>
    RepairRequestSortInfo(
      sorted: json['sorted'] as bool?,
      empty: json['empty'] as bool?,
      unsorted: json['unsorted'] as bool?,
    );

Map<String, dynamic> _$RepairRequestSortInfoToJson(
        RepairRequestSortInfo instance) =>
    <String, dynamic>{
      'sorted': instance.sorted,
      'empty': instance.empty,
      'unsorted': instance.unsorted,
    };
