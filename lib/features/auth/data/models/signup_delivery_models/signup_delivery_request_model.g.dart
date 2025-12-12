// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_delivery_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupDeliveryRequestModel _$SignupDeliveryRequestModelFromJson(
        Map<String, dynamic> json) =>
    SignupDeliveryRequestModel(
      email: json['email'] as String,
      password: json['password'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$SignupDeliveryRequestModelToJson(
        SignupDeliveryRequestModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'address': instance.address,
      'phone': instance.phone,
    };
