import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'timestamp')
  final String? timestamp;

  @JsonKey(name: 'message')
  final String? message;

  NotificationModel({
    this.id,
    this.timestamp,
    this.message,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
