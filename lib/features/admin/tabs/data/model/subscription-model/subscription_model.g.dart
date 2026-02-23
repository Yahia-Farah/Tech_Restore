// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) =>
    SubscriptionModel(
      id: json['id'] as String?,
      subscriptionId: json['subscriptionId'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      planType: json['planType'] as String?,
      planName: json['planName'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      months: (json['months'] as num?)?.toInt(),
      duration: json['duration'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      isActive: json['isActive'] as bool?,
      amount: (json['amount'] as num?)?.toDouble(),
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      paymentType: json['paymentType'] as String?,
      paymentReference: json['paymentReference'] as String?,
      transactionId: json['transactionId'] as String?,
      details: json['details'] as String?,
      paidAt: json['paidAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SubscriptionModelToJson(SubscriptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subscriptionId': instance.subscriptionId,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'planType': instance.planType,
      'planName': instance.planName,
      'price': instance.price,
      'months': instance.months,
      'duration': instance.duration,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isActive': instance.isActive,
      'amount': instance.amount,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'paymentType': instance.paymentType,
      'paymentReference': instance.paymentReference,
      'transactionId': instance.transactionId,
      'details': instance.details,
      'paidAt': instance.paidAt,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
