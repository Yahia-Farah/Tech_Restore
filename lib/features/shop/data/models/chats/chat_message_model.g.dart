// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: json['id'] as String?,
      sessionId: json['sessionId'] as String?,
      senderId: json['senderId'] as String?,
      senderType: json['senderType'] as String?,
      senderName: json['senderName'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'senderId': instance.senderId,
      'senderType': instance.senderType,
      'senderName': instance.senderName,
      'content': instance.content,
      'createdAt': instance.createdAt,
    };
