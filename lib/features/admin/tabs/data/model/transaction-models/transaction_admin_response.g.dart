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
      size: (json['size'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) =>
              ContentTransactionAdmin.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num?)?.toInt(),
      sort: (json['sort'] as List<dynamic>?)
          ?.map((e) => SortTransaction.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
      pageable: json['pageable'] == null
          ? null
          : PageableAdminTransaction.fromJson(
              json['pageable'] as Map<String, dynamic>),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$TransactionAdminModelResponseToJson(
        TransactionAdminModelResponse instance) =>
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
