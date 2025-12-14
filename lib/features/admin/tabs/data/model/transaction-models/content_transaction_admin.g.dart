// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_transaction_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentTransactionAdmin _$ContentTransactionAdminFromJson(
        Map<String, dynamic> json) =>
    ContentTransactionAdmin(
      id: json['id'] as String?,
      amount: (json['amount'] as num?)?.toInt(),
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

Map<String, dynamic> _$ContentTransactionAdminToJson(
        ContentTransactionAdmin instance) =>
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
