import 'package:json_annotation/json_annotation.dart';

part 'admin_states_response.g.dart';

@JsonSerializable()
class AdminStatesResponse {
  @JsonKey(name: "users")
  final int? users;
  @JsonKey(name: "shops")
  final int? shops;
  @JsonKey(name: "repairs")
  final int? repairs;
  @JsonKey(name: "orders")
  final int? orders;

  AdminStatesResponse ({
    this.users,
    this.shops,
    this.repairs,
    this.orders,
  });

  factory AdminStatesResponse.fromJson(Map<String, dynamic> json) {
    return _$AdminStatesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AdminStatesResponseToJson(this);
  }
}


