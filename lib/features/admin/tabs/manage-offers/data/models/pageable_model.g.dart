// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageableModel _$PageableModelFromJson(Map<String, dynamic> json) =>
    PageableModel(
      offset: (json['offset'] as num?)?.toInt(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => SortModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageNumber: (json['pageNumber'] as num?)?.toInt(),
      pageSize: (json['pageSize'] as num?)?.toInt(),
      paged: json['paged'] as bool?,
      unpaged: json['unpaged'] as bool?,
    );

Map<String, dynamic> _$PageableModelToJson(PageableModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'sort': instance.sort,
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };
