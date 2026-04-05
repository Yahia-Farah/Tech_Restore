// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewListResponse _$ReviewListResponseFromJson(Map<String, dynamic> json) =>
    ReviewListResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReviewListResponseToJson(ReviewListResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
