// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortModel _$SortModelFromJson(Map<String, dynamic> json) => SortModel(
      direction: json['direction'] as String?,
      nullHandling: json['nullHandling'] as String?,
      ascending: json['ascending'] as bool?,
      property: json['property'] as String?,
      ignoreCase: json['ignoreCase'] as bool?,
    );

Map<String, dynamic> _$SortModelToJson(SortModel instance) => <String, dynamic>{
      'direction': instance.direction,
      'nullHandling': instance.nullHandling,
      'ascending': instance.ascending,
      'property': instance.property,
      'ignoreCase': instance.ignoreCase,
    };
