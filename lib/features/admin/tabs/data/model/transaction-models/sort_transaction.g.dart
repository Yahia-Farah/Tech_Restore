// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sort_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SortTransaction _$SortTransactionFromJson(Map<String, dynamic> json) =>
    SortTransaction(
      direction: json['direction'] as String?,
      nullHandling: json['nullHandling'] as String?,
      ascending: json['ascending'] as bool?,
      property: json['property'] as String?,
      ignoreCase: json['ignoreCase'] as bool?,
    );

Map<String, dynamic> _$SortTransactionToJson(SortTransaction instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'nullHandling': instance.nullHandling,
      'ascending': instance.ascending,
      'property': instance.property,
      'ignoreCase': instance.ignoreCase,
    };
