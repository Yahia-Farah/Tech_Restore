import 'package:json_annotation/json_annotation.dart';

part 'chat_session_model.g.dart';

@JsonSerializable()
class ChatSessionModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'shopId')
  final String? shopId;

  @JsonKey(name: 'shopName')
  final String? shopName;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'lastMessage')
  final ChatMessageModel? lastMessage;

  @JsonKey(name: 'active')
  final bool? active;

  ChatSessionModel({
    this.id,
    this.userId,
    this.userName,
    this.shopId,
    this.shopName,
    this.createdAt,
    this.lastMessage,
    this.active,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ChatSessionModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatSessionModelToJson(this);
}

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

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}

