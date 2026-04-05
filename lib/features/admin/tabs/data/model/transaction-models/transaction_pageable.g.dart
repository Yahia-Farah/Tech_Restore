// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionPageable _$TransactionPageableFromJson(Map<String, dynamic> json) =>
    TransactionPageable(
      offset: (json['offset'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : TransactionSort.fromJson(json['sort'] as Map<String, dynamic>),
      paged: json['paged'] as bool?,
      pageSize: (json['pageSize'] as num?)?.toInt(),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$TransactionPageableToJson(
        TransactionPageable instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'sort': instance.sort,
      'paged': instance.paged,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
      'unpaged': instance.unpaged,
    };
