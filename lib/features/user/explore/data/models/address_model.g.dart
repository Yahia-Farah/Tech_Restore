// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      id: json['id'] as String,
      state: json['state'] as String,
      city: json['city'] as String,
      street: json['street'] as String,
      building: json['building'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isDefault: json['default'] as bool,
      fullAddress: json['fullAddress'] as String,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'notes': instance.notes,
      'createdAt': instance.createdAt.toIso8601String(),
      'default': instance.isDefault,
      'fullAddress': instance.fullAddress,
    };
