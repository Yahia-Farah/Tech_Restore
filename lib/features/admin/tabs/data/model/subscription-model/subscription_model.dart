import 'package:json_annotation/json_annotation.dart';

part 'subscription_model.g.dart';

@JsonSerializable()
class SubscriptionModel {
  final String? id;

  // Subscription Info
  final String? subscriptionId;
  final String? shopId;
  final String? shopName;
  final String? planType;
  final String? planName;
  final double? price;
  final int? months;
  final String? duration;
  final String? startDate;
  final String? endDate;
  final bool? isActive;

  // Payment Info
  final double? amount;
  final String? paymentMethod;
  final String? paymentStatus;
  final String? paymentType;
  final String? paymentReference;
  final String? transactionId;
  final String? details;
  final String? paidAt;

  final String? createdAt;
  final String? updatedAt;

  SubscriptionModel({
    this.id,
    this.subscriptionId,
    this.shopId,
    this.shopName,
    this.planType,
    this.planName,
    this.price,
    this.months,
    this.duration,
    this.startDate,
    this.endDate,
    this.isActive,
    this.amount,
    this.paymentMethod,
    this.paymentStatus,
    this.paymentType,
    this.paymentReference,
    this.transactionId,
    this.details,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionModelToJson(this);
}