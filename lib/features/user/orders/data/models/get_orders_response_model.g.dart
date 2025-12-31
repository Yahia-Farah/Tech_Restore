// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_orders_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetOrdersResponseModel _$GetOrdersResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetOrdersResponseModel(
      totalPages: (json['totalPages'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      first: json['first'] as bool,
      last: json['last'] as bool,
      size: (json['size'] as num).toInt(),
      content: (json['content'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num).toInt(),
      sort: SortModel.fromJson(json['sort'] as Map<String, dynamic>),
      numberOfElements: (json['numberOfElements'] as num).toInt(),
      pageable:
          PageableModel.fromJson(json['pageable'] as Map<String, dynamic>),
      empty: json['empty'] as bool,
    );

Map<String, dynamic> _$GetOrdersResponseModelToJson(
        GetOrdersResponseModel instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'last': instance.last,
      'size': instance.size,
      'content': instance.content,
      'number': instance.number,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'pageable': instance.pageable,
      'empty': instance.empty,
    };
