// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressRequest _$AddressRequestFromJson(Map<String, dynamic> json) =>
    AddressRequest(
      state: json['state'] as String?,
      city: json['city'] as String?,
      street: json['street'] as String?,
      building: json['building'] as String?,
      notes: json['notes'] as String?,
      isDefault: json['isDefault'] as bool?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$AddressRequestToJson(AddressRequest instance) =>
    <String, dynamic>{
      'state': instance.state,
      'city': instance.city,
      'street': instance.street,
      'building': instance.building,
      'notes': instance.notes,
      'isDefault': instance.isDefault,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
