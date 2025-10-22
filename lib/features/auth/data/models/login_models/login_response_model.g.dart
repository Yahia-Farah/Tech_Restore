// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      accessToken: json['access_token'] as String?,
      role: (json['role'] as List<dynamic>?)?.map((e) => e as String).toList(),
      id: json['id'] as String?,
      tokenType: json['token_type'] as String?,
      expiresIn: (json['expires_in'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'role': instance.role,
      'id': instance.id,
      'token_type': instance.tokenType,
      'expires_in': instance.expiresIn,
    };
