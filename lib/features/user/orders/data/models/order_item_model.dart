import 'package:json_annotation/json_annotation.dart';

part 'order_item_model.g.dart';

@JsonSerializable()
class OrderItemModel {
  final String id;
  final String productId;
  final int quantity;
  final double priceAtCheckout;
  final String shopId;
  final double subtotal;
  final String productName;
  final double price;
  final String shopName;

  const OrderItemModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.priceAtCheckout,
    required this.shopId,
    required this.subtotal,
    required this.productName,
    required this.price,
    required this.shopName,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) =>
      _$OrderItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemModelToJson(this);
}
