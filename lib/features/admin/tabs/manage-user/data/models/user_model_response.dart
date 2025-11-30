import 'package:json_annotation/json_annotation.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/data/models/user_model.dart';

part 'user_model_response.g.dart';
@JsonSerializable()
class UserListResponse {
  final List<UserModel>? content;

  UserListResponse({this.content});

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}