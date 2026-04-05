// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_sort.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionSort _$TransactionSortFromJson(Map<String, dynamic> json) =>
    TransactionSort(
      sorted: json['sorted'] as bool?,
      unsorted: json['unsorted'] as bool?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$TransactionSortToJson(TransactionSort instance) =>
    <String, dynamic>{
      'sorted': instance.sorted,
      'unsorted': instance.unsorted,
      'empty': instance.empty,
    };
