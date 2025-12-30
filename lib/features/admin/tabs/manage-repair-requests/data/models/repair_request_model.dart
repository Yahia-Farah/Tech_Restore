import 'package:json_annotation/json_annotation.dart';

part 'repair_request_model.g.dart';

@JsonSerializable()
class RepairRequestModel {
  final String? id;
  final String? customerId;
  final String? customerName;
  final String? customerPhone;
  final String? shopId;
  final String? shopName;
  final String? deviceType;
  final String? deviceModel;
  final String? issueDescription;
  final String? status;
  final double? estimatedCost;
  final double? finalCost;
  final String? priority;
  final List<String>? images;
  final String? notes;
  final String? assignedTechnician;
  final String? createdAt;
  final String? updatedAt;
  final String? completedAt;

  RepairRequestModel({
    this.id,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.shopId,
    this.shopName,
    this.deviceType,
    this.deviceModel,
    this.issueDescription,
    this.status,
    this.estimatedCost,
    this.finalCost,
    this.priority,
    this.images,
    this.notes,
    this.assignedTechnician,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
  });

  factory RepairRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RepairRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$RepairRequestModelToJson(this);
}