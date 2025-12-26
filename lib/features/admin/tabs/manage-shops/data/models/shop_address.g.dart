// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopAddress _$ShopAddressFromJson(Map<String, dynamic> json) => ShopAddress(
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      building: json['building'] as String?,
      isDefault: json['isDefault'] as String?,
    );

Map<String, dynamic> _$ShopAddressToJson(ShopAddress instance) =>
    <String, dynamic>{
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
      'isDefault': instance.isDefault,
    };
