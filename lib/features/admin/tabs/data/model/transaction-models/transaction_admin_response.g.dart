// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_admin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionAdminModelResponse _$TransactionAdminModelResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionAdminModelResponse(
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => TransactionContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num?)?.toInt(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => TransactionSort.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageable: json['pageable'] == null
          ? null
          : TransactionPageable.fromJson(
              json['pageable'] as Map<String, dynamic>),
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$TransactionAdminModelResponseToJson(
        TransactionAdminModelResponse instance) =>
    <String, dynamic>{
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'first': instance.first,
      'last': instance.last,
      'numberOfElements': instance.numberOfElements,
      'size': instance.size,
      'content': instance.content,
      'number': instance.number,
      'sort': instance.sort,
      'pageable': instance.pageable,
      'empty': instance.empty,
    };
