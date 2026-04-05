// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_admin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionAdminModelResponse _$TransactionAdminModelResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionAdminModelResponse(
      totalElements: (json['totalElements'] as num?)?.toInt(),
      totalPages: (json['totalPages'] as num?)?.toInt(),
      pageable: json['pageable'] == null
          ? null
          : TransactionPageable.fromJson(
              json['pageable'] as Map<String, dynamic>),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      size: (json['size'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => TransactionContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : TransactionSort.fromJson(json['sort'] as Map<String, dynamic>),
      numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$TransactionAdminModelResponseToJson(
        TransactionAdminModelResponse instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'pageable': instance.pageable,
      'first': instance.first,
      'last': instance.last,
      'size': instance.size,
      'content': instance.content,
      'number': instance.number,
      'sort': instance.sort,
      'numberOfElements': instance.numberOfElements,
      'empty': instance.empty,
    };
