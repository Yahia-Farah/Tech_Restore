import 'chat_message_model.dart';

class ChatSessionModel {
  final String? id;
  final String? userId;
  final String? userName;
  final String? shopId;
  final String? shopName;
  final bool? active;
  final String? createdAt;
  final String? endedAt;
  final ChatMessageModel? lastMessage;

  ChatSessionModel({
    this.id,
    this.userId,
    this.userName,
    this.shopId,
    this.shopName,
    this.active,
    this.createdAt,
    this.endedAt,
    this.lastMessage,
  });

  factory ChatSessionModel.fromJson(Map<String, dynamic> json) {
    return ChatSessionModel(
      id: json['id']?.toString(),
      userId: json['userId']?.toString(),
      userName: json['userName']?.toString(),
      shopId: json['shopId']?.toString(),
      shopName: json['shopName']?.toString(),
      active: json['active'] as bool?,
      createdAt: json['createdAt']?.toString(),
      endedAt: json['endedAt']?.toString(),
      lastMessage:
          json['lastMessage'] != null
              ? ChatMessageModel.fromJson(json['lastMessage'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'shopId': shopId,
      'shopName': shopName,
      'active': active,
      'createdAt': createdAt,
      'endedAt': endedAt,
      'lastMessage': lastMessage?.toJson(),
    };
  }

  ChatSessionModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? shopId,
    String? shopName,
    bool? active,
    String? createdAt,
    String? endedAt,
    ChatMessageModel? lastMessage,
  }) {
    return ChatSessionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      endedAt: endedAt ?? this.endedAt,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}
