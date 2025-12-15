import 'package:json_annotation/json_annotation.dart';

part 'content_delivery_admin.g.dart';

@JsonSerializable()
class ContentDeliveryAdmin {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "activate")
  final bool? activate;
  @JsonKey(name: "verified")
  final bool? verified;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "notificationHistory")
  final String? notificationHistory;
  @JsonKey(name: "activeOrderDeliveries")
  final int? activeOrderDeliveries;
  @JsonKey(name: "activeRepairDeliveries")
  final int? activeRepairDeliveries;
  @JsonKey(name: "totalCompletedDeliveries")
  final int? totalCompletedDeliveries;

  ContentDeliveryAdmin({
    this.id,
    this.email,
    this.name,
    this.address,
    this.phone,
    this.activate,
    this.verified,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.notificationHistory,
    this.activeOrderDeliveries,
    this.activeRepairDeliveries,
    this.totalCompletedDeliveries,
  });

  factory ContentDeliveryAdmin.fromJson(Map<String, dynamic> json) {
    return _$ContentDeliveryAdminFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ContentDeliveryAdminToJson(this);
  }
}
