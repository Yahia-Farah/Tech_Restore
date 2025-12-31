// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemModel _$OrderItemModelFromJson(Map<String, dynamic> json) =>
    OrderItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      quantity: (json['quantity'] as num).toInt(),
      priceAtCheckout: (json['priceAtCheckout'] as num).toDouble(),
      shopId: json['shopId'] as String,
      subtotal: (json['subtotal'] as num).toDouble(),
      productName: json['productName'] as String,
      price: (json['price'] as num).toDouble(),
      shopName: json['shopName'] as String,
    );

Map<String, dynamic> _$OrderItemModelToJson(OrderItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'quantity': instance.quantity,
      'priceAtCheckout': instance.priceAtCheckout,
      'shopId': instance.shopId,
      'subtotal': instance.subtotal,
      'productName': instance.productName,
      'price': instance.price,
      'shopName': instance.shopName,
    };
