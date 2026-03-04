// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      discountValue: (json['discountValue'] as num?)?.toDouble(),
      discountType: json['discountType'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      status: json['status'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
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
      'shopName': instance.shopName,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
