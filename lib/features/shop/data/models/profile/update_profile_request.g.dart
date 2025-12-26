// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileRequest(
      name: json['name'] as String?,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'phone': instance.phone,
      'password': instance.password,
    };
