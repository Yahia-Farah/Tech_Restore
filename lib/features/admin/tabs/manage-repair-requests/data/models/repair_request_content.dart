import 'package:json_annotation/json_annotation.dart';

part 'repair_request_content.g.dart';

@JsonSerializable()
class RepairRequestContent {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "deliveryId")
  final String? deliveryId;
  @JsonKey(name: "userId")
  final String? userId;
  @JsonKey(name: "shopId")
  final String? shopId;
  @JsonKey(name: "deliveryAddress")
  final String? deliveryAddress;
  @JsonKey(name: "paymentId")
  final String? paymentId;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "deliveryMethod")
  final String? deliveryMethod;
  @JsonKey(name: "deviceCategory")
  final String? deviceCategory;
  @JsonKey(name: "paymentMethod")
  final String? paymentMethod;
  @JsonKey(name: "confirmed")
  final bool? confirmed;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "status")
  final String? status;
  @JsonKey(name: "shopName")
  final String? shopName;
  @JsonKey(name: "deliveryAddressDetails")
  final String? deliveryAddressDetails;

  RepairRequestContent({
    this.id,
    this.deliveryId,
    this.userId,
    this.shopId,
    this.deliveryAddress,
    this.paymentId,
    this.description,
    this.deliveryMethod,
    this.deviceCategory,
    this.paymentMethod,
    this.confirmed,
    this.price,
    this.status,
    this.shopName,
    this.deliveryAddressDetails,
  });

  factory RepairRequestContent.fromJson(Map<String, dynamic> json) {
    return _$RepairRequestContentFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$RepairRequestContentToJson(this);
  }
}
