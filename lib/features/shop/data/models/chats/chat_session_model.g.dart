// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatSessionModel _$ChatSessionModelFromJson(Map<String, dynamic> json) =>
    ChatSessionModel(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      createdAt: json['createdAt'] as String?,
      lastMessage: json['lastMessage'] == null
          ? null
          : ChatMessageModel.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
      active: json['active'] as bool?,
    );

Map<String, dynamic> _$ChatSessionModelToJson(ChatSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'userName': instance.userName,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'createdAt': instance.createdAt,
      'lastMessage': instance.lastMessage,
      'active': instance.active,
    };

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
