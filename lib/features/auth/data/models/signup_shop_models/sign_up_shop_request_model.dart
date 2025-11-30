import 'package:json_annotation/json_annotation.dart';

part 'sign_up_shop_request_model.g.dart';

@JsonSerializable()
class SignUpShopRequestModel {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "verified")
  final bool? verified;
  @JsonKey(name: "shopType")
  final String shopType;
  @JsonKey(name: "shopAddress")
  final ShopAddress shopAddress;
  @JsonKey(name: "rating")
  final double? rating;

  SignUpShopRequestModel ({
    required this.email,
    required this.password,
    required this.name,
    required this.description,
    required this.phone,
    this.verified = false,
    required this.shopType,
    required this.shopAddress,
    this.rating = 0,
  });

  factory SignUpShopRequestModel.fromJson(Map<String, dynamic> json) {
    return _$SignUpShopRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpShopRequestModelToJson(this);
  }
}

@JsonSerializable()
class ShopAddress {
  @JsonKey(name: "state")
  final String state;
  @JsonKey(name: "city")
  final String city;
  @JsonKey(name: "street")
  final String street;
  @JsonKey(name: "building")
  final String building;
  @JsonKey(name: "isDefault")
  final String? isDefault;

  ShopAddress ({
    required this.state,
    required this.city,
    required this.street,
    required this.building,
    this.isDefault = "true",
  });

  factory ShopAddress.fromJson(Map<String, dynamic> json) {
    return _$ShopAddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShopAddressToJson(this);
  }
}


