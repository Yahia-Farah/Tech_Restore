import 'package:json_annotation/json_annotation.dart';

part 'signup_delivery_request_model.g.dart';

@JsonSerializable()
class SignupDeliveryRequestModel {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "address")
  final String address;
  @JsonKey(name: "phone")
  final String phone;

  SignupDeliveryRequestModel({
    required this.email,
    required this.password,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory SignupDeliveryRequestModel.fromJson(Map<String, dynamic> json) {
    return _$SignupDeliveryRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignupDeliveryRequestModelToJson(this);
  }
}
