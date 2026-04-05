// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestPageable _$RepairRequestPageableFromJson(
        Map<String, dynamic> json) =>
    RepairRequestPageable(
      paged: json['paged'] as bool?,
      offset: (json['offset'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : RepairRequestSortInfo.fromJson(
              json['sort'] as Map<String, dynamic>),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$RepairRequestPageableToJson(
        RepairRequestPageable instance) =>
    <String, dynamic>{
      'paged': instance.paged,
      'offset': instance.offset,
      'sort': instance.sort,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'unpaged': instance.unpaged,
    };
