import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel {
  final String? id;
  final String? shopId;
  final String? shopName;
  final String? planType;
  final String? planName;
  final double? price;
  final String? duration;
  final String? startDate;
  final String? endDate;
  final bool? isActive;
  final String? paymentMethod;
  final String? createdAt;
  final String? updatedAt;

  SubscriptionModel({
    this.id,
    this.shopId,
    this.shopName,
    this.planType,
    this.planName,
    this.price,
    this.duration,
    this.startDate,
    this.endDate,
    this.isActive,
    this.paymentMethod,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}