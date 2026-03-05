// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestModel _$RepairRequestModelFromJson(Map<String, dynamic> json) =>
    RepairRequestModel(
      totalPages: (json['totalPages'] as num?)?.toInt(),
      totalElements: (json['totalElements'] as num?)?.toInt(),
      first: json['first'] as bool?,
      last: json['last'] as bool?,
      numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
      size: (json['size'] as num?)?.toInt(),
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => RepairRequestContent.fromJson(e as Map<String, dynamic>))
          .toList(),
      number: (json['number'] as num?)?.toInt(),
      sort: json['sort'] == null
          ? null
          : RepairRequestSortInfo.fromJson(
              json['sort'] as Map<String, dynamic>),
      pageable: json['pageable'] == null
          ? null
          : RepairRequestPageable.fromJson(
              json['pageable'] as Map<String, dynamic>),
      empty: json['empty'] as bool?,
    );

Map<String, dynamic> _$RepairRequestModelToJson(RepairRequestModel instance) =>
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
