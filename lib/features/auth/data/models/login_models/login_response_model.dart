  import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: "access_token")
  final String? accessToken;
  @JsonKey(name: "role")
  final List<String>? role;
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "token_type")
  final String? tokenType;
  @JsonKey(name: "expires_in")
  final int? expiresIn;

  LoginResponseModel ({
    this.accessToken,
    this.role,
    this.id,
    this.tokenType,
    this.expiresIn,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return _$LoginResponseModelFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoginResponseModelToJson(this);
  }
}


