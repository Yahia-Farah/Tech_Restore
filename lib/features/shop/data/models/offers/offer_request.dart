import 'package:json_annotation/json_annotation.dart';

part 'offer_request.g.dart';

@JsonSerializable()
class OfferRequest {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "discountValue")
  final double? discountValue;
  @JsonKey(name: "discountType")
  final String? discountType;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "startDate")
  final String? startDate;
  @JsonKey(name: "endDate")
  final String? endDate;

  OfferRequest ({
    this.name,
    this.description,
    this.discountValue,
    this.discountType,
    this.status,
    this.startDate,
    this.endDate,
  });

  factory OfferRequest.fromJson(Map<String, dynamic> json) {
    return _$OfferRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OfferRequestToJson(this);
  }
}


