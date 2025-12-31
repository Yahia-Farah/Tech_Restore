// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageableModel _$PageableModelFromJson(Map<String, dynamic> json) =>
    PageableModel(
      offset: (json['offset'] as num).toInt(),
      sort: json['sort'] as Map<String, dynamic>,
      unpaged: json['unpaged'] as bool,
      paged: json['paged'] as bool,
      pageSize: (json['pageSize'] as num).toInt(),
      pageNumber: (json['pageNumber'] as num).toInt(),
    );

Map<String, dynamic> _$PageableModelToJson(PageableModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'sort': instance.sort,
      'unpaged': instance.unpaged,
      'paged': instance.paged,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
    };
