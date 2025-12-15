import 'package:json_annotation/json_annotation.dart';

part 'chat_message_model.g.dart';

@JsonSerializable()
class ChatMessageModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'sessionId')
  final String? sessionId;

  @JsonKey(name: 'userId')
  final String? userId;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'shopId')
  final String? shopId;

  @JsonKey(name: 'shopName')
  final String? shopName;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'content')
  final String? content;

  @JsonKey(name: 'sentBy')
  final String? sentBy;

  @JsonKey(name: 'senderId')
  final String? senderId;

  @JsonKey(name: 'senderType')
  final String? senderType;

  @JsonKey(name: 'senderName')
  final String? senderName;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'isRead')
  final bool? isRead;

  @JsonKey(name: 'readAt')
  final String? readAt;

  ChatMessageModel({
    this.id,
    this.sessionId,
    this.userId,
    this.userName,
    this.shopId,
    this.shopName,
    this.message,
    this.content,
    this.sentBy,
    this.senderId,
    this.senderType,
    this.senderName,
    this.createdAt,
    this.isRead,
    this.readAt,
  });

  String? get displayContent => message ?? content;
  String? get displaySenderType => sentBy ?? senderType;
  String? get displaySenderName {
    if (sentBy == 'USER') return userName;
    if (sentBy == 'SHOP') return shopName;
    return senderName;
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}