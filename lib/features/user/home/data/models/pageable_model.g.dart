// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageableModel _$PageableModelFromJson(Map<String, dynamic> json) =>
    PageableModel(
      offset: (json['offset'] as num).toInt(),
      sort: SortInfoModel.fromJson(json['sort'] as Map<String, dynamic>),
      paged: json['paged'] as bool,
      pageSize: (json['pageSize'] as num).toInt(),
      pageNumber: (json['pageNumber'] as num).toInt(),
      unpaged: json['unpaged'] as bool,
    );

Map<String, dynamic> _$PageableModelToJson(PageableModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'sort': instance.sort,
      'paged': instance.paged,
      'pageSize': instance.pageSize,
      'pageNumber': instance.pageNumber,
      'unpaged': instance.unpaged,
    };
