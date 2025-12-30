// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestListResponse _$RepairRequestListResponseFromJson(
        Map<String, dynamic> json) =>
    RepairRequestListResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => RepairRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RepairRequestListResponseToJson(
        RepairRequestListResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
