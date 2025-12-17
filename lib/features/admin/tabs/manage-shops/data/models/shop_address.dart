import 'package:json_annotation/json_annotation.dart';

part 'shop_address.g.dart';

@JsonSerializable()
class ShopAddress {
  final String? state;
  final String? city;
  final String? street;
  final String? building;
  final String? isDefault;

  ShopAddress({
    this.state,
    this.city,
    this.street,
    this.building,
    this.isDefault,
  });

  factory ShopAddress.fromJson(Map<String, dynamic> json) =>
      _$ShopAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShopAddressToJson(this);
}
