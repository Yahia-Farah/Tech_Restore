import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/manage-products/data/models/product_model.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductListResponse {
  final List<ProductModel>? content;

  ProductListResponse({this.content});

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);
}