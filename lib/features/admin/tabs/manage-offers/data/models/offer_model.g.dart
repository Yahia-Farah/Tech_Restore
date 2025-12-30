// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: json['id'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      offerType: json['offerType'] as String?,
      discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
      discountAmount: (json['discountAmount'] as num?)?.toDouble(),
      minOrderAmount: (json['minOrderAmount'] as num?)?.toDouble(),
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      isActive: json['isActive'] as bool?,
      usageLimit: (json['usageLimit'] as num?)?.toInt(),
      usedCount: (json['usedCount'] as num?)?.toInt(),
      applicableProducts: (json['applicableProducts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      applicableCategories: (json['applicableCategories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      promoCode: json['promoCode'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'title': instance.title,
      'description': instance.description,
      'offerType': instance.offerType,
      'discountPercentage': instance.discountPercentage,
      'discountAmount': instance.discountAmount,
      'minOrderAmount': instance.minOrderAmount,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isActive': instance.isActive,
      'usageLimit': instance.usageLimit,
      'usedCount': instance.usedCount,
      'applicableProducts': instance.applicableProducts,
      'applicableCategories': instance.applicableCategories,
      'promoCode': instance.promoCode,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
