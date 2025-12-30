// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repair_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepairRequestModel _$RepairRequestModelFromJson(Map<String, dynamic> json) =>
    RepairRequestModel(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      customerName: json['customerName'] as String?,
      customerPhone: json['customerPhone'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      deviceType: json['deviceType'] as String?,
      deviceModel: json['deviceModel'] as String?,
      issueDescription: json['issueDescription'] as String?,
      status: json['status'] as String?,
      estimatedCost: (json['estimatedCost'] as num?)?.toDouble(),
      finalCost: (json['finalCost'] as num?)?.toDouble(),
      priority: json['priority'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      notes: json['notes'] as String?,
      assignedTechnician: json['assignedTechnician'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      completedAt: json['completedAt'] as String?,
    );

Map<String, dynamic> _$RepairRequestModelToJson(RepairRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customerName': instance.customerName,
      'customerPhone': instance.customerPhone,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'deviceType': instance.deviceType,
      'deviceModel': instance.deviceModel,
      'issueDescription': instance.issueDescription,
      'status': instance.status,
      'estimatedCost': instance.estimatedCost,
      'finalCost': instance.finalCost,
      'priority': instance.priority,
      'images': instance.images,
      'notes': instance.notes,
      'assignedTechnician': instance.assignedTechnician,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'completedAt': instance.completedAt,
    };
