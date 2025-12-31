// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopModel _$ShopModelFromJson(Map<String, dynamic> json) => ShopModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      verified: json['verified'] as bool,
      phone: json['phone'] as String,
      rating: (json['rating'] as num?)?.toInt(),
      shopAddress: json['shopAddress'] == null
          ? null
          : AddressModel.fromJson(json['shopAddress'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      shopType: json['shopType'] as String,
      activate: json['activate'] as bool,
    );

Map<String, dynamic> _$ShopModelToJson(ShopModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'description': instance.description,
      'verified': instance.verified,
      'phone': instance.phone,
      'rating': instance.rating,
      'shopAddress': instance.shopAddress,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'shopType': instance.shopType,
      'activate': instance.activate,
    };
