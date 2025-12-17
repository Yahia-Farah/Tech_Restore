import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "price")
  final double? price;
  @JsonKey(name: "stock")
  final int? stock;
  @JsonKey(name: "imageUrl")
  final String? imageUrl;
  @JsonKey(name: "condition")
  final String? condition;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "categoryId")
  final String? categoryId;
  @JsonKey(name: "categoryName")
  final String? categoryName;
  @JsonKey(name: "deleted")
  final bool? deleted;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.imageUrl,
    this.condition,
    this.createdAt,
    this.categoryId,
    this.categoryName,
    this.deleted,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return _$ProductModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProductModelToJson(this);
  }
}
