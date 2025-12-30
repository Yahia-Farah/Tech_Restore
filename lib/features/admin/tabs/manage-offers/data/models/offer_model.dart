import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  final String? id;
  final String? shopId;
  final String? shopName;
  final String? title;
  final String? description;
  final String? offerType;
  final double? discountPercentage;
  final double? discountAmount;
  final double? minOrderAmount;
  final String? startDate;
  final String? endDate;
  final bool? isActive;
  final int? usageLimit;
  final int? usedCount;
  final List<String>? applicableProducts;
  final List<String>? applicableCategories;
  final String? promoCode;
  final String? createdAt;
  final String? updatedAt;

  OfferModel({
    this.id,
    this.shopId,
    this.shopName,
    this.title,
    this.description,
    this.offerType,
    this.discountPercentage,
    this.discountAmount,
    this.minOrderAmount,
    this.startDate,
    this.endDate,
    this.isActive,
    this.usageLimit,
    this.usedCount,
    this.applicableProducts,
    this.applicableCategories,
    this.promoCode,
    this.createdAt,
    this.updatedAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}