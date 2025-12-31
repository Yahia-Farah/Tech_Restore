import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'address_model.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String description;
  final bool verified;
  final String phone;
  final int? rating;
  final AddressModel? shopAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String shopType;
  final bool activate;

  const ShopModel({
    required this.id,
    required this.email,
    required this.name,
    required this.description,
    required this.verified,
    required this.phone,
    this.rating,
    this.shopAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.shopType,
    required this.activate,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    email,
    name,
    description,
    verified,
    phone,
    rating,
    shopAddress,
    createdAt,
    updatedAt,
    shopType,
    activate,
  ];
}
