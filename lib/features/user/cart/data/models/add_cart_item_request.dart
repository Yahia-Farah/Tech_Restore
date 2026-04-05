import 'package:json_annotation/json_annotation.dart';

part 'add_cart_item_request.g.dart';

@JsonSerializable()
class AddCartItemRequest {
  final String productId;
  final int quantity;

  AddCartItemRequest({required this.productId, required this.quantity});

  factory AddCartItemRequest.fromJson(Map<String, dynamic> json) =>
      _$AddCartItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddCartItemRequestToJson(this);
}
