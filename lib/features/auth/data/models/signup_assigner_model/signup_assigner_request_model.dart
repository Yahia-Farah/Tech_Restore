import 'package:json_annotation/json_annotation.dart';

part 'signup_assigner_request_model.g.dart';

@JsonSerializable()
class SignupAssignerRequestModel {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "department")
  final String department;
  @JsonKey(name: "phone")
  final String phone;

  SignupAssignerRequestModel ({
    required this.email,
    required this.password,
    required this.name,
    required this.department,
    required this.phone,
  });

  factory SignupAssignerRequestModel.fromJson(Map<String, dynamic> json) {
    return _$SignupAssignerRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignupAssignerRequestModelToJson(this);
  }
}


