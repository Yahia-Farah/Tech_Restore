import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessageModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'sessionId')
  final String? sessionId;

  @JsonKey(name: 'senderId')
  final String? senderId;

  @JsonKey(name: 'senderType')
  final String? senderType;

  @JsonKey(name: 'senderName')
  final String? senderName;

  @JsonKey(name: 'content')
  final String? content;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  ChatMessageModel({
    this.id,
    this.sessionId,
    this.senderId,
    this.senderType,
    this.senderName,
    this.content,
    this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}

