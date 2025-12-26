import 'package:json_annotation/json_annotation.dart';

part 'shop_profile_model.g.dart';

@JsonSerializable()
class ShopProfileModel {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "verified")
  final bool? verified;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "rating")
  final double? rating;
  @JsonKey(name: "shopAddress")
  final ShopAddress? shopAddress;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "shopType")
  final String? shopType;
  @JsonKey(name: "activate")
  final bool? activate;

  ShopProfileModel({
    this.id,
    this.email,
    this.name,
    this.description,
    this.verified,
    this.phone,
    this.rating,
    this.shopAddress,
    this.createdAt,
    this.updatedAt,
    this.shopType,
    this.activate,
  });

  factory ShopProfileModel.fromJson(Map<String, dynamic> json) {
    return _$ShopProfileModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShopProfileModelToJson(this);
  }
}

@JsonSerializable()
class ShopAddress {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "building")
  final String? building;
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "default")
  final bool? isDefault;
  @JsonKey(name: "fullAddress")
  final String? fullAddress;

  ShopAddress({
    this.id,
    this.state,
    this.city,
    this.street,
    this.building,
    this.latitude,
    this.longitude,
    this.notes,
    this.createdAt,
    this.isDefault,
    this.fullAddress,
  });

  factory ShopAddress.fromJson(Map<String, dynamic> json) {
    return _$ShopAddressFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ShopAddressToJson(this);
  }
}