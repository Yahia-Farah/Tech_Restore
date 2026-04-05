import 'package:json_annotation/json_annotation.dart';

part 'review_model.g.dart';

@JsonSerializable()
class ReviewModel {
  final String? id;
  final String? customerId;
  final String? customerName;
  final String? shopId;
  final String? shopName;
  final int? rating;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;
  final bool? isApproved;
  final bool? isFlagged;

  ReviewModel({
    this.id,
    this.customerId,
    this.customerName,
    this.shopId,
    this.shopName,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.isApproved,
    this.isFlagged,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewModelToJson(this);
}