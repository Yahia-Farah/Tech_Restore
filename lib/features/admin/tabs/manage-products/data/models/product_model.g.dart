// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      quantity: (json['quantity'] as num?)?.toInt(),
      category: json['category'] as String?,
      categoryId: json['categoryId'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      isActive: json['isActive'] as bool?,
      inStock: json['inStock'] as bool?,
      sku: json['sku'] as String?,
      brand: json['brand'] as String?,
      condition: json['condition'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'quantity': instance.quantity,
      'category': instance.category,
      'categoryId': instance.categoryId,
      'images': instance.images,
      'isActive': instance.isActive,
      'inStock': instance.inStock,
      'sku': instance.sku,
      'brand': instance.brand,
      'condition': instance.condition,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
