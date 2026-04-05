// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionContent _$TransactionContentFromJson(Map<String, dynamic> json) =>
    TransactionContent(
      id: json['id'] as String?,
      amount: json['amount'] as num?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      paymentType: json['paymentType'] as String?,
      paymentReference: json['paymentReference'] as String?,
      transactionId: json['transactionId'] as String?,
      details: json['details'] as String?,
      paidAt: json['paidAt'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      userId: json['userId'] as String?,
      shopId: json['shopId'] as String?,
    );

Map<String, dynamic> _$TransactionContentToJson(TransactionContent instance) =>
    <String, dynamic>{
      'id': instance.id,
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
      'userId': instance.userId,
      'shopId': instance.shopId,
    };
