// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferResponse _$OfferResponseFromJson(Map<String, dynamic> json) =>
    OfferResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      discountValue: (json['discountValue'] as num?)?.toDouble(),
      discountType: json['discountType'],
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      status: json['status'] as String?,
      shopId: json['shopId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      shopName: json['shopName'] as String?,
    );

Map<String, dynamic> _$OfferResponseToJson(OfferResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'discountValue': instance.discountValue,
      'discountType': instance.discountType,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'status': instance.status,
      'shopId': instance.shopId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'shopName': instance.shopName,
    };
