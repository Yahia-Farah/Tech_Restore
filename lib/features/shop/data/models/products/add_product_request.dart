import 'package:json_annotation/json_annotation.dart';

part 'add_product_request.g.dart';

@JsonSerializable()
class AddProductRequest {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "price")
  final double? price;
  @JsonKey(name: "imageUrl")
  final String? imageUrl;
  @JsonKey(name: "category")
  final Category? category;
  @JsonKey(name: "stockQuantity")
  final int? stockQuantity;
  @JsonKey(name: "condition")
  final String? condition;

  AddProductRequest ({
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.category,
    this.stockQuantity,
    this.condition,
  });

  factory AddProductRequest.fromJson(Map<String, dynamic> json) {
    return _$AddProductRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddProductRequestToJson(this);
  }
}

@JsonSerializable()
class Category {
  @JsonKey(name: "id")
  final String? id;

  Category ({
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CategoryToJson(this);
  }
}


