// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopListResponse _$ShopListResponseFromJson(Map<String, dynamic> json) =>
    ShopListResponse(
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => ShopModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopListResponseToJson(ShopListResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
    };
