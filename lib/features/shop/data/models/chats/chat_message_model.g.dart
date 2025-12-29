// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatMessageModel _$ChatMessageModelFromJson(Map<String, dynamic> json) =>
    ChatMessageModel(
      id: json['id'] as String?,
      sessionId: json['sessionId'] as String?,
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      message: json['message'] as String?,
      content: json['content'] as String?,
      sentBy: json['sentBy'] as String?,
      senderId: json['senderId'] as String?,
      senderType: json['senderType'] as String?,
      senderName: json['senderName'] as String?,
      createdAt: json['createdAt'] as String?,
      isRead: json['isRead'] as bool?,
      readAt: json['readAt'] as String?,
    );

Map<String, dynamic> _$ChatMessageModelToJson(ChatMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sessionId': instance.sessionId,
      'userId': instance.userId,
      'userName': instance.userName,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'message': instance.message,
      'content': instance.content,
      'sentBy': instance.sentBy,
      'senderId': instance.senderId,
      'senderType': instance.senderType,
      'senderName': instance.senderName,
      'createdAt': instance.createdAt,
      'isRead': instance.isRead,
      'readAt': instance.readAt,
    };
