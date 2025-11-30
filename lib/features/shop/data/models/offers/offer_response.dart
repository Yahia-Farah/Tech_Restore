import 'package:json_annotation/json_annotation.dart';

part 'offer_response.g.dart';

@JsonSerializable()
class OfferResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "discountValue")
  final double? discountValue;
  @JsonKey(name: "discountType")
  final dynamic discountType;
  @JsonKey(name: "startDate")
  final String? startDate;
  @JsonKey(name: "endDate")
  final String? endDate;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "shopId")
  final String? shopId;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "shopName")
  final String? shopName;

  OfferResponse ({
    this.id,
    this.name,
    this.description,
    this.discountValue,
    this.discountType,
    this.startDate,
    this.endDate,
    this.status,
    this.shopId,
    this.createdAt,
    this.updatedAt,
    this.shopName,
  });

  factory OfferResponse.fromJson(Map<String, dynamic> json) {
    return _$OfferResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OfferResponseToJson(this);
  }
}


