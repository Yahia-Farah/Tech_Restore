// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductRequest _$AddProductRequestFromJson(Map<String, dynamic> json) =>
    AddProductRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      stockQuantity: (json['stockQuantity'] as num?)?.toInt(),
      condition: json['condition'] as String?,
    );

Map<String, dynamic> _$AddProductRequestToJson(AddProductRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
      'stockQuantity': instance.stockQuantity,
      'condition': instance.condition,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
    };
