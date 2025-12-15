// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_admin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryAdminResponse _$DeliveryAdminResponseFromJson(
        Map<String, dynamic> json) =>
    DeliveryAdminResponse(
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ContentDeliveryAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num?)?.toInt(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => SortDeliveryAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
      pageable: json['pageable'] == null
          ? null
          : PageableDeliveryAdmin.fromJson(
              json['pageable'] as Map<String, dynamic>),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$DeliveryAdminResponseToJson(
        DeliveryAdminResponse instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'size': instance.size,
      'content': instance.content,
      'number': instance.number,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'pageable': instance.pageable,
      'first': instance.first,
      'last': instance.last,
      'empty': instance.empty,
    };
