// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestPageable _$RepairRequestPageableFromJson(
        Map<String, dynamic> json) =>
    RepairRequestPageable(
      offset: (json['offset'] as num?)?.toInt(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => RepairRequestSort.fromJson(e as Map<String, dynamic>))
          .toList(),
      paged: json['paged'] as bool?,
      pageSize: (json['pageSize'] as num?)?.toInt(),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$RepairRequestPageableToJson(
        RepairRequestPageable instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'sort': instance.sort,
      'paged': instance.paged,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
      'unpaged': instance.unpaged,
    };
