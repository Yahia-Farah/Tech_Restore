// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      stock: (json['stock'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      condition: json['condition'] as String?,
      createdAt: json['createdAt'] as String?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'stock': instance.stock,
      'imageUrl': instance.imageUrl,
      'condition': instance.condition,
      'createdAt': instance.createdAt,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'deleted': instance.deleted,
    };
