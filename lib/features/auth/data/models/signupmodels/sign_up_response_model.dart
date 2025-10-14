import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response_model.g.dart';

@JsonSerializable()
class SignUpResponseModel {
  @JsonKey(name: "message")
  final String? message;

  SignUpResponseModel ({
    this.message,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return _$SignUpResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SignUpResponseModelToJson(this);
  }
}


