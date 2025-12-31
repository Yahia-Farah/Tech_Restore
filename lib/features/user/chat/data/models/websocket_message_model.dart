class WebSocketMessageModel {
  final String? type;
  final String? action;
  final dynamic payload;
  final String? senderId;
  final String? senderType;
  final String? recipientId;
  final String? status;
  final String? message;
  final String? timestamp;

  WebSocketMessageModel({
    this.type,
    this.action,
    this.payload,
    this.senderId,
    this.senderType,
    this.recipientId,
    this.status,
    this.message,
    this.timestamp,
  });

  factory WebSocketMessageModel.fromJson(Map<String, dynamic> json) {
    return WebSocketMessageModel(
      type: json['type']?.toString(),
      action: json['action']?.toString(),
      payload: json['payload'],
      senderId: json['senderId']?.toString(),
      senderType: json['senderType']?.toString(),
      recipientId: json['recipientId']?.toString(),
      status: json['status']?.toString(),
      message: json['message']?.toString(),
      timestamp: json['timestamp']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'action': action,
      'payload': payload,
      'senderId': senderId,
      'senderType': senderType,
      'recipientId': recipientId,
      'status': status,
      'message': message,
      'timestamp': timestamp,
    };
  }

  WebSocketMessageModel copyWith({
    String? type,
    String? action,
    dynamic payload,
    String? senderId,
    String? senderType,
    String? recipientId,
    String? status,
    String? message,
    String? timestamp,
  }) {
    return WebSocketMessageModel(
      type: type ?? this.type,
      action: action ?? this.action,
      payload: payload ?? this.payload,
      senderId: senderId ?? this.senderId,
      senderType: senderType ?? this.senderType,
      recipientId: recipientId ?? this.recipientId,
      status: status ?? this.status,
      message: message ?? this.message,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
