import 'package:json_annotation/json_annotation.dart';
import 'order_item_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final String id;
  final String userId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String deliveryAddressId;
  final double totalPrice;
  final String status;
  final String paymentMethod;
  final DateTime createdAt;
  final String? paymentId;
  final List<OrderItemModel> orderItems;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.deliveryAddressId,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.createdAt,
    this.paymentId,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  String get formattedDate {
    return '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}';
  }

  String get itemsCount {
    final totalItems = orderItems.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );
    return '$totalItems product(s)';
  }

  String get formattedTotalPrice {
    return '${totalPrice.toStringAsFixed(2)} EGP';
  }
}
