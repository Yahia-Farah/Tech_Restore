// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestContent _$RepairRequestContentFromJson(
        Map<String, dynamic> json) =>
    RepairRequestContent(
      id: json['id'] as String?,
      deliveryId: json['deliveryId'] as String?,
      userId: json['userId'] as String?,
      shopId: json['shopId'] as String?,
      deliveryAddress: json['deliveryAddress'] as String?,
      paymentId: json['paymentId'] as String?,
      description: json['description'] as String?,
      deliveryMethod: json['deliveryMethod'] as String?,
      deviceCategory: json['deviceCategory'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      confirmed: json['confirmed'] as bool?,
      price: (json['price'] as num?)?.toInt(),
      status: json['status'] as String?,
      shopName: json['shopName'] as String?,
      deliveryAddressDetails: json['deliveryAddressDetails'] as String?,
    );

Map<String, dynamic> _$RepairRequestContentToJson(
        RepairRequestContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deliveryId': instance.deliveryId,
      'userId': instance.userId,
      'shopId': instance.shopId,
      'deliveryAddress': instance.deliveryAddress,
      'paymentId': instance.paymentId,
      'description': instance.description,
      'deliveryMethod': instance.deliveryMethod,
      'deviceCategory': instance.deviceCategory,
      'paymentMethod': instance.paymentMethod,
      'confirmed': instance.confirmed,
      'price': instance.price,
      'status': instance.status,
      'shopName': instance.shopName,
      'deliveryAddressDetails': instance.deliveryAddressDetails,
    };
