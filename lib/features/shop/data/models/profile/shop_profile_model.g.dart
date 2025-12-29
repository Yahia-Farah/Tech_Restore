// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopProfileModel _$ShopProfileModelFromJson(Map<String, dynamic> json) =>
    ShopProfileModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      verified: json['verified'] as bool?,
      phone: json['phone'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      shopAddress: json['shopAddress'] == null
          ? null
          : ShopAddress.fromJson(json['shopAddress'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      shopType: json['shopType'] as String?,
      activate: json['activate'] as bool?,
    );

Map<String, dynamic> _$ShopProfileModelToJson(ShopProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'description': instance.description,
      'verified': instance.verified,
      'phone': instance.phone,
      'rating': instance.rating,
      'shopAddress': instance.shopAddress,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'shopType': instance.shopType,
      'activate': instance.activate,
    };

ShopAddress _$ShopAddressFromJson(Map<String, dynamic> json) => ShopAddress(
      id: json['id'] as String?,
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      building: json['building'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] as String?,
      isDefault: json['default'] as bool?,
      fullAddress: json['fullAddress'] as String?,
    );

Map<String, dynamic> _$ShopAddressToJson(ShopAddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
      'default': instance.isDefault,
      'fullAddress': instance.fullAddress,
    };
