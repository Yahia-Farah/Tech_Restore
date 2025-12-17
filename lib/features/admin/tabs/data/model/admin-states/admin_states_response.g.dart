// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_states_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminStatesResponse _$AdminStatesResponseFromJson(Map<String, dynamic> json) =>
    AdminStatesResponse(
      users: (json['users'] as num?)?.toInt(),
      shops: (json['shops'] as num?)?.toInt(),
      repairs: (json['repairs'] as num?)?.toInt(),
      orders: (json['orders'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdminStatesResponseToJson(
  AdminStatesResponse instance,
) => <String, dynamic>{
  'users': instance.users,
  'shops': instance.shops,
  'repairs': instance.repairs,
  'orders': instance.orders,
};
