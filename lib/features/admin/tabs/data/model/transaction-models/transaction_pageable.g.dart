// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionPageable _$TransactionPageableFromJson(Map<String, dynamic> json) =>
    TransactionPageable(
      paged: json['paged'] as bool?,
      offset: (json['offset'] as num?)?.toInt(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => TransactionSort.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$TransactionPageableToJson(
        TransactionPageable instance) =>
    <String, dynamic>{
      'paged': instance.paged,
      'offset': instance.offset,
      'sort': instance.sort,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'unpaged': instance.unpaged,
    };
