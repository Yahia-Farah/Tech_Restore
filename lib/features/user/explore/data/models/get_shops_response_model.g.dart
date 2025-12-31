// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shops_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetShopsResponseModel _$GetShopsResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetShopsResponseModel(
      content: (json['content'] as List<dynamic>)
          .map((e) => ShopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable:
          PageableModel.fromJson(json['pageable'] as Map<String, dynamic>),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      last: json['last'] as bool,
      size: (json['size'] as num).toInt(),
      number: (json['number'] as num).toInt(),
      sort: SortModel.fromJson(json['sort'] as Map<String, dynamic>),
      numberOfElements: (json['numberOfElements'] as num).toInt(),
      first: json['first'] as bool,
      empty: json['empty'] as bool,
    );

Map<String, dynamic> _$GetShopsResponseModelToJson(
        GetShopsResponseModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'pageable': instance.pageable,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'last': instance.last,
      'size': instance.size,
      'number': instance.number,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'first': instance.first,
      'empty': instance.empty,
    };
