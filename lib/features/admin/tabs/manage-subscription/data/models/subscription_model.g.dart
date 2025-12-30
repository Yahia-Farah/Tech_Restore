// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      id: json['id'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      planType: json['planType'] as String?,
      planName: json['planName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      duration: json['duration'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      isActive: json['isActive'] as bool?,
      paymentMethod: json['paymentMethod'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'planType': instance.planType,
      'planName': instance.planName,
      'price': instance.price,
      'duration': instance.duration,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isActive': instance.isActive,
      'paymentMethod': instance.paymentMethod,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
