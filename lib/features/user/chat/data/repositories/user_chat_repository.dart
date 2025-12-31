import 'package:injectable/injectable.dart';
import '../data_source/user_chat_remote_datasource.dart';
import '../models/chat_message_model.dart';
import '../models/chat_session_model.dart';
// ignore: unused_import
import '../models/websocket_message_model.dart';

abstract class UserChatRepository {
  Future<List<ChatSessionModel>> getMyChatSessions();
  Future<List<ChatMessageModel>> getChatMessages(String userId, String shopId);
  Future<void> markMessagesAsRead(String userId, String shopId);
  Future<void> closeChatSession(String userId, String shopId);
  Future<Map<String, int>> getUnreadMessageCount(String userId);

  // WebSocket methods
  Future<void> connectWebSocket(String userId, String shopId);
  void disconnectWebSocket();
  void sendMessage(String userId, String shopId, ChatMessageModel message);
  void markAsRead(String userId, String shopId);
  void sendTypingIndicator(String userId, String shopId);
  void endSession(String userId, String shopId);
  Stream<ChatMessageModel>? get messageStream;
}

@Injectable(as: UserChatRepository)
class UserChatRepositoryImpl implements UserChatRepository {
  final UserChatRemoteDataSource _remoteDataSource;
  Stream<ChatMessageModel>? _transformedMessageStream;

  UserChatRepositoryImpl(this._remoteDataSource);

  @override
  Stream<ChatMessageModel>? get messageStream => _transformedMessageStream;

  @override
  Future<List<ChatSessionModel>> getMyChatSessions() async {
    try {
      return await _remoteDataSource.getMyChatSessions();
    } catch (e) {
      throw Exception('Failed to fetch chat sessions: $e');
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatMessages(
    String userId,
    String shopId,
  ) async {
    try {
      return await _remoteDataSource.getChatMessages(userId, shopId);
    } catch (e) {
      throw Exception('Failed to fetch messages: $e');
    }
  }

  @override
  Future<void> markMessagesAsRead(String userId, String shopId) async {
    try {
      await _remoteDataSource.markMessagesAsRead(userId, shopId);
    } catch (e) {
      throw Exception('Failed to mark messages as read: $e');
    }
  }

  @override
  Future<void> closeChatSession(String userId, String shopId) async {
    try {
      await _remoteDataSource.closeChatSession(userId, shopId);
    } catch (e) {
      throw Exception('Failed to close chat session: $e');
    }
  }

  @override
  Future<Map<String, int>> getUnreadMessageCount(String userId) async {
    try {
      return await _remoteDataSource.getUnreadMessageCount(userId);
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }

  @override
  Future<void> connectWebSocket(String userId, String shopId) async {
    try {
      await _remoteDataSource.connectWebSocket(userId, shopId);

      // Transform WebSocketMessageModel stream to ChatMessageModel stream
      final wsStream = _remoteDataSource.messageStream;
      if (wsStream != null) {
        _transformedMessageStream = wsStream
            .cast<WebSocketMessageModel>()
            .where((WebSocketMessageModel wsMessage) {
              // Only process CHAT messages with SEND action
              return wsMessage.type == 'CHAT' && wsMessage.action == 'SEND';
            })
            .map<ChatMessageModel>((WebSocketMessageModel wsMessage) {
              // Convert WebSocketMessageModel to ChatMessageModel
              if (wsMessage.payload is Map<String, dynamic>) {
                return ChatMessageModel.fromJson(wsMessage.payload);
              } else {
                // Handle case where payload is a string (the message text)
                return ChatMessageModel(
                  userId:
                      wsMessage.senderType == 'USER'
                          ? wsMessage.senderId
                          : userId,
                  shopId:
                      wsMessage.senderType == 'SHOP'
                          ? wsMessage.senderId
                          : shopId,
                  message: wsMessage.payload?.toString() ?? '',
                  sentBy: wsMessage.senderType ?? 'USER',
                  createdAt:
                      wsMessage.timestamp ?? DateTime.now().toIso8601String(),
                );
              }
            });
      }
    } catch (e) {
      throw Exception('Failed to connect WebSocket: $e');
    }
  }

  @override
  void disconnectWebSocket() {
    _remoteDataSource.disconnectWebSocket();
    _transformedMessageStream = null;
  }

  @override
  void sendMessage(String userId, String shopId, ChatMessageModel message) {
    try {
      _remoteDataSource.sendMessage(userId, shopId, message);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  void markAsRead(String userId, String shopId) {
    try {
      _remoteDataSource.markAsRead(userId, shopId);
    } catch (e) {
      throw Exception('Failed to mark as read: $e');
    }
  }

  @override
  void sendTypingIndicator(String userId, String shopId) {
    try {
      _remoteDataSource.sendTypingIndicator(userId, shopId);
    } catch (e) {
      throw Exception('Failed to send typing indicator: $e');
    }
  }

  @override
  void endSession(String userId, String shopId) {
    try {
      _remoteDataSource.endSession(userId, shopId);
    } catch (e) {
      throw Exception('Failed to end session: $e');
    }
  }
}
