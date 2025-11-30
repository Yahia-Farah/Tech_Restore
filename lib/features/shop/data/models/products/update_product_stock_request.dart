import 'package:json_annotation/json_annotation.dart';

part 'update_product_stock_request.g.dart';

@JsonSerializable()
class UpdateProductStockRequest {
  @JsonKey(name: "newStock")
  final int newStock;

  UpdateProductStockRequest ({
    required this.newStock,
  });

  factory UpdateProductStockRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateProductStockRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateProductStockRequestToJson(this);
  }
}


