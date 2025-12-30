// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferListResponse _$OfferListResponseFromJson(Map<String, dynamic> json) =>
    OfferListResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => OfferModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OfferListResponseToJson(OfferListResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
