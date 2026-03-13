// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortInfoModel _$SortInfoModelFromJson(Map<String, dynamic> json) =>
    SortInfoModel(
      empty: json['empty'] as bool,
      sorted: json['sorted'] as bool,
      unsorted: json['unsorted'] as bool,
    );

Map<String, dynamic> _$SortInfoModelToJson(SortInfoModel instance) =>
    <String, dynamic>{
      'empty': instance.empty,
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
    };
