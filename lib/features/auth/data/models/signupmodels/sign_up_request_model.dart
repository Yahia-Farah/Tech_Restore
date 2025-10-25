import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequest {
  @JsonKey(name: "first_name")
  final String? firstName;
  @JsonKey(name: "last_name")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "password")
  final String? password;

  SignUpRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.password,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) {
    return _$SignUpRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpRequestToJson(this);
  }
}
