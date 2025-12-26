// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_shop_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpShopRequestModel _$SignUpShopRequestModelFromJson(
        Map<String, dynamic> json) =>
    SignUpShopRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      phone: json['phone'] as String,
      verified: json['verified'] as bool? ?? false,
      shopType: json['shopType'] as String,
      shopAddress:
          ShopAddress.fromJson(json['shopAddress'] as Map<String, dynamic>),
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$SignUpShopRequestModelToJson(
        SignUpShopRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'description': instance.description,
      'phone': instance.phone,
      'verified': instance.verified,
      'shopType': instance.shopType,
      'shopAddress': instance.shopAddress,
      'rating': instance.rating,
    };

ShopAddress _$ShopAddressFromJson(Map<String, dynamic> json) => ShopAddress(
      state: json['state'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      building: json['building'] as String,
      isDefault: json['isDefault'] as String? ?? "true",
    );

Map<String, dynamic> _$ShopAddressToJson(ShopAddress instance) =>
    <String, dynamic>{
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
      'isDefault': instance.isDefault,
    };
