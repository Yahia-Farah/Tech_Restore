import 'package:json_annotation/json_annotation.dart';
import 'cart_item_model.dart';

part 'cart_model.g.dart';

@JsonSerializable()
class CartModel {
  final String id;
  final String userId;
  final List<CartItemModel> items;
  final double totalPrice;
  final int totalItems;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  CartModel({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.totalItems,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
