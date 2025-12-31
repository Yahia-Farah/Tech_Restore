class ChatMessageModel {
  final String? id;
  final String? userId;
  final String? userName;
  final String? shopId;
  final String? shopName;
  final String? message;
  final String? sentBy;
  final String? createdAt;
  final bool? isRead;
  final String? readAt;

  ChatMessageModel({
    this.id,
    this.userId,
    this.userName,
    this.shopId,
    this.shopName,
    this.message,
    this.sentBy,
    this.createdAt,
    this.isRead,
    this.readAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id']?.toString(),
      userId: json['userId']?.toString(),
      userName: json['userName']?.toString(),
      shopId: json['shopId']?.toString(),
      shopName: json['shopName']?.toString(),
      message: json['message']?.toString(),
      sentBy: json['sentBy']?.toString(),
      createdAt: json['createdAt']?.toString(),
      isRead: json['isRead'] as bool?,
      readAt: json['readAt']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'shopId': shopId,
      'shopName': shopName,
      'message': message,
      'sentBy': sentBy,
      'createdAt': createdAt,
      'isRead': isRead,
      'readAt': readAt,
    };
  }

  String get displaySenderName =>
      sentBy == 'USER' ? (userName ?? '') : (shopName ?? '');
  String get displayContent => message ?? '';
  String get displaySenderType => sentBy ?? 'USER';

  ChatMessageModel copyWith({
    String? id,
    String? userId,
    String? userName,
    String? shopId,
    String? shopName,
    String? message,
    String? sentBy,
    String? createdAt,
    bool? isRead,
    String? readAt,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      shopId: shopId ?? this.shopId,
      shopName: shopName ?? this.shopName,
      message: message ?? this.message,
      sentBy: sentBy ?? this.sentBy,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
    );
  }
}
