// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_sort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSort _$TransactionSortFromJson(Map<String, dynamic> json) =>
    TransactionSort(
      direction: json['direction'] as String?,
      nullHandling: json['nullHandling'] as String?,
      ascending: json['ascending'] as bool?,
      property: json['property'] as String?,
      ignoreCase: json['ignoreCase'] as bool?,
    );

Map<String, dynamic> _$TransactionSortToJson(TransactionSort instance) =>
    <String, dynamic>{
      'direction': instance.direction,
      'nullHandling': instance.nullHandling,
      'ascending': instance.ascending,
      'property': instance.property,
      'ignoreCase': instance.ignoreCase,
    };
