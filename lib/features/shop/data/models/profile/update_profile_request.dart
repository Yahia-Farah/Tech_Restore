import 'package:json_annotation/json_annotation.dart';

part 'update_profile_request.g.dart';

@JsonSerializable()
class UpdateProfileRequest {
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "password")
  final String? password;

  UpdateProfileRequest({
    this.name,
    this.description,
    this.phone,
    this.password,
  });

  factory UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    return _$UpdateProfileRequestFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UpdateProfileRequestToJson(this);
  }
}