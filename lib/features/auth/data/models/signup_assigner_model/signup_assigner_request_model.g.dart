// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_assigner_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupAssignerRequestModel _$SignupAssignerRequestModelFromJson(
  Map<String, dynamic> json,
) => SignupAssignerRequestModel(
  email: json['email'] as String,
  password: json['password'] as String,
  name: json['name'] as String,
  department: json['department'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$SignupAssignerRequestModelToJson(
  SignupAssignerRequestModel instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'name': instance.name,
  'department': instance.department,
  'phone': instance.phone,
};
