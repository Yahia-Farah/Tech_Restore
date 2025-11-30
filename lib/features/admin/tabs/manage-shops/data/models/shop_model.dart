import 'package:json_annotation/json_annotation.dart';

import '../../../../../auth/data/models/signup_shop_models/sign_up_shop_request_model.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel {
  final String? id;
  final String? email;
  final String? name;
  final String? description;
  final bool? verified;
  final String? phone;
  final double? rating;
  final ShopAddress? shopAddress;
  final String? createdAt;
  final String? updatedAt;
  final String? shopType;
  final bool? activate;

  ShopModel({
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

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);
}




