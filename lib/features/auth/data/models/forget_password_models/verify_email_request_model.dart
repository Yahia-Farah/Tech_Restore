import 'package:json_annotation/json_annotation.dart';

part 'verify_email_request_model.g.dart';

@JsonSerializable()
class VerifyEmailRequestModel {
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "optCode")
  final String optCode;

  VerifyEmailRequestModel({required this.email, required this.optCode});

  factory VerifyEmailRequestModel.fromJson(Map<String, dynamic> json) {
    return _$VerifyEmailRequestModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$VerifyEmailRequestModelToJson(this);
  }
}
