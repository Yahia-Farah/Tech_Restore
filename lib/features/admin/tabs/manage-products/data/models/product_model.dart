import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String? id;
  final String? shopId;
  final String? shopName;
  final String? name;
  final String? description;
  final double? price;
  final int? quantity;
  final String? category;
  final String? categoryId;
  final List<String>? images;
  final bool? isActive;
  final bool? inStock;
  final String? sku;
  final String? brand;
  final String? condition;
  final String? createdAt;
  final String? updatedAt;

  ProductModel({
    this.id,
    this.shopId,
    this.shopName,
    this.name,
    this.description,
    this.price,
    this.quantity,
    this.category,
    this.categoryId,
    this.images,
    this.isActive,
    this.inStock,
    this.sku,
    this.brand,
    this.condition,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}