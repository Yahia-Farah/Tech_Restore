// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionListResponse _$SubscriptionListResponseFromJson(
        Map<String, dynamic> json) =>
    SubscriptionListResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => SubscriptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SubscriptionListResponseToJson(
        SubscriptionListResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
