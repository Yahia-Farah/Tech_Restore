import 'package:json_annotation/json_annotation.dart';

part 'transaction_content.g.dart';

@JsonSerializable()
class TransactionContent {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "amount")
  final num? amount;
  @JsonKey(name: "paymentMethod")
  final String? paymentMethod;
  @JsonKey(name: "paymentStatus")
  final String? paymentStatus;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "paymentReference")
  final String? paymentReference;
  @JsonKey(name: "transactionId")
  final String? transactionId;
  @JsonKey(name: "details")
  final String? details;
  @JsonKey(name: "paidAt")
  final String? paidAt;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "shopId")
  final String? shopId;

  TransactionContent({
    this.id,
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
    this.userId,
    this.shopId,
  });

  factory TransactionContent.fromJson(Map<String, dynamic> json) {
    return _$TransactionContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TransactionContentToJson(this);
  }
}

