// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceModel _$DeviceModelFromJson(Map<String, dynamic> json) => DeviceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stock: (json['stock'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      condition: json['condition'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      categoryId: json['categoryId'] as String,
      categoryName: json['categoryName'] as String,
      deleted: json['deleted'] as bool,
    );

Map<String, dynamic> _$DeviceModelToJson(DeviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'stock': instance.stock,
      'imageUrl': instance.imageUrl,
      'condition': instance.condition,
      'createdAt': instance.createdAt.toIso8601String(),
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'deleted': instance.deleted,
    };
