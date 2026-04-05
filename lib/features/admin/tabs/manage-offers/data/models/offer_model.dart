import 'package:json_annotation/json_annotation.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel {
  final String? id;
  final String? name;
  final String? description;
  final double? discountValue;
  final String? discountType;
  final String? startDate;
  final String? endDate;
  final String? status;
  final String? shopId;
  final String? shopName;
  final String? createdAt;
  final String? updatedAt;

  OfferModel({
    this.id,
    this.name,
    this.description,
    this.discountValue,
    this.discountType,
    this.startDate,
    this.endDate,
    this.status,
    this.shopId,
    this.shopName,
    this.createdAt,
    this.updatedAt,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) =>
      _$OfferModelFromJson(json);

  Map<String, dynamic> toJson() => _$OfferModelToJson(this);
}