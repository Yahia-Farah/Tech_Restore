// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_delivery_admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContentDeliveryAdmin _$ContentDeliveryAdminFromJson(
  Map<String, dynamic> json,
) => ContentDeliveryAdmin(
  id: json['id'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
  address: json['address'] as String?,
  phone: json['phone'] as String?,
  activate: json['activate'] as bool?,
  verified: json['verified'] as bool?,
  status: json['status'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
  notificationHistory: json['notificationHistory'] as String?,
  activeOrderDeliveries: (json['activeOrderDeliveries'] as num?)?.toInt(),
  activeRepairDeliveries: (json['activeRepairDeliveries'] as num?)?.toInt(),
  totalCompletedDeliveries: (json['totalCompletedDeliveries'] as num?)?.toInt(),
);

Map<String, dynamic> _$ContentDeliveryAdminToJson(
  ContentDeliveryAdmin instance,
) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'address': instance.address,
  'phone': instance.phone,
  'activate': instance.activate,
  'verified': instance.verified,
  'status': instance.status,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
  'notificationHistory': instance.notificationHistory,
  'activeOrderDeliveries': instance.activeOrderDeliveries,
  'activeRepairDeliveries': instance.activeRepairDeliveries,
  'totalCompletedDeliveries': instance.totalCompletedDeliveries,
};
