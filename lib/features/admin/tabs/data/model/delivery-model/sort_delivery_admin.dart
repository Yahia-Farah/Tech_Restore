import 'package:json_annotation/json_annotation.dart';

part 'sort_delivery_admin.g.dart';

@JsonSerializable()
class SortDeliveryAdmin {
  @JsonKey(name: "direction")
  final String? direction;
  @JsonKey(name: "nullHandling")
  final String? nullHandling;
  @JsonKey(name: "ascending")
  final bool? ascending;
  @JsonKey(name: "property")
  final String? property;
  @JsonKey(name: "ignoreCase")
  final bool? ignoreCase;

  SortDeliveryAdmin({
    this.direction,
    this.nullHandling,
    this.ascending,
    this.property,
    this.ignoreCase,
  });

  factory SortDeliveryAdmin.fromJson(Map<String, dynamic> json) {
    return _$SortDeliveryAdminFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SortDeliveryAdminToJson(this);
  }
}


