// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_sort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestSort _$RepairRequestSortFromJson(Map<String, dynamic> json) =>
    RepairRequestSort(
      direction: json['direction'] as String?,
      nullHandling: json['nullHandling'] as String?,
      ascending: json['ascending'] as bool?,
      property: json['property'] as String?,
      ignoreCase: json['ignoreCase'] as bool?,
    );

Map<String, dynamic> _$RepairRequestSortToJson(RepairRequestSort instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'nullHandling': instance.nullHandling,
      'ascending': instance.ascending,
      'property': instance.property,
      'ignoreCase': instance.ignoreCase,
    };
