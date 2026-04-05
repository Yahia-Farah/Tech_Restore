// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_cart_item_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCartItemRequest _$AddCartItemRequestFromJson(Map<String, dynamic> json) =>
    AddCartItemRequest(
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$AddCartItemRequestToJson(AddCartItemRequest instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'quantity': instance.quantity,
    };
