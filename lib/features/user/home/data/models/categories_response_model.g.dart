// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponseModel _$CategoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoriesResponseModel(
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num).toInt(),
      sort: SortInfoModel.fromJson(json['sort'] as Map<String, dynamic>),
      first: json['first'] as bool,
      last: json['last'] as bool,
      numberOfElements: (json['numberOfElements'] as num).toInt(),
      pageable:
          PageableModel.fromJson(json['pageable'] as Map<String, dynamic>),
      empty: json['empty'] as bool,
    );

Map<String, dynamic> _$CategoriesResponseModelToJson(
        CategoriesResponseModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'size': instance.size,
      'content': instance.content,
      'number': instance.number,
      'sort': instance.sort,
      'first': instance.first,
      'last': instance.last,
      'numberOfElements': instance.numberOfElements,
      'pageable': instance.pageable,
      'empty': instance.empty,
    };
