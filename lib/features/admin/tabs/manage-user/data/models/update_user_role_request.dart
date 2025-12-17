import 'package:json_annotation/json_annotation.dart';

part 'update_user_role_request.g.dart';

@JsonSerializable()
class UpdateUserRoleRequest {
  final String role;

  UpdateUserRoleRequest({required this.role});

  factory UpdateUserRoleRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserRoleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserRoleRequestToJson(this);
}
