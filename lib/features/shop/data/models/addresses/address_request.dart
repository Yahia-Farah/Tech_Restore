import 'package:json_annotation/json_annotation.dart';

part 'address_request.g.dart';

@JsonSerializable()
class AddressRequest {
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "city")
  final String? city;
  @JsonKey(name: "street")
  final String? street;
  @JsonKey(name: "building")
  final String? building;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "isDefault")
  final bool? isDefault;
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;

  AddressRequest({
    this.state,
    this.city,
    this.street,
    this.building,
    this.notes,
    this.isDefault,
    this.latitude,
    this.longitude,
  });

  factory AddressRequest.fromJson(Map<String, dynamic> json) {
    return _$AddressRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddressRequestToJson(this);
  }
}