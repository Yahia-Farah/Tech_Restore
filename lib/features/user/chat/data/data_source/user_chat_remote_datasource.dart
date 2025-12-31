import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import '../../../../../core/api/api_constants/api_constants.dart';
import '../../../../../core/contants/secure_storage.dart';
import '../../../../auth/domain/services/auth_services.dart';
import '../models/chat_message_model.dart';
import '../models/chat_session_model.dart';


abstract class UserChatRemoteDataSource {
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

@Injectable(as: UserChatRemoteDataSource)
class UserChatRemoteDataSourceImpl implements UserChatRemoteDataSource {
  final Dio _dio;
  StompClient? _stompClient;
  final StreamController<ChatMessageModel> _messageController =
      StreamController<ChatMessageModel>.broadcast();
  bool _isConnected = false;

  UserChatRemoteDataSourceImpl(this._dio);

  @override
  Stream<ChatMessageModel>? get messageStream => _messageController.stream;

  @override
  Future<List<ChatSessionModel>> getMyChatSessions() async {
    try {
      final token = await AuthService.getToken();
      final response = await _dio.get(
        'chats/my/sessions',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ChatSessionModel.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to fetch chat sessions: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      log('Error fetching chat sessions: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error fetching chat sessions: $e');
      throw Exception('Failed to fetch chat sessions');
    }
  }

  @override
  Future<List<ChatMessageModel>> getChatMessages(
      String userId,
      String shopId,
      ) async {
    try {
      final token = await AuthService.getToken();
      final response = await _dio.get(
        'chats/$userId/shop/$shopId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => ChatMessageModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch messages: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      log('Error fetching messages: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error fetching messages: $e');
      throw Exception('Failed to fetch messages');
    }
  }

  @override
  Future<void> markMessagesAsRead(String userId, String shopId) async {
    try {
      final token = await SecureStorage.read('token');
      final response = await _dio.put(
        'chats/$userId/shop/$shopId/mark-read',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to mark messages as read: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      log('Error marking messages as read: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error marking messages as read: $e');
      throw Exception('Failed to mark messages as read');
    }
  }

  @override
  Future<void> closeChatSession(String userId, String shopId) async {
    try {
      final token = await SecureStorage.read('token');
      final response = await _dio.delete(
        'chats/$userId/shop/$shopId/close',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to close chat session: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      log('Error closing chat session: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error closing chat session: $e');
      throw Exception('Failed to close chat session');
    }
  }

  @override
  Future<Map<String, int>> getUnreadMessageCount(String userId) async {
    try {
      final token = await SecureStorage.read('token');
      final response = await _dio.get(
        'chats/$userId/unread-count',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        return {'unreadCount': (data['unreadCount'] as num?)?.toInt() ?? 0};
      } else {
        throw Exception(
          'Failed to get unread count: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      log('Error getting unread count: ${e.message}');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Unexpected error getting unread count: $e');
      throw Exception('Failed to get unread count');
    }
  }

  @override
  Future<void> connectWebSocket(
      String userId,
      String shopId,
      ) async {
    try {
      disconnectWebSocket(); // Close existing connection if any

      final token = await AuthService.getToken();
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      // Get base URL and construct WebSocket URL
      final baseUrl = ApiConstant.baseUrl.replaceAll('/api/', '');
      final wsUrl = '$baseUrl/ws';

      log('Connecting to WebSocket: $wsUrl');

      _stompClient = StompClient(
        config: StompConfig.sockJS(
          url: wsUrl,
          onConnect: (StompFrame frame) {
            _isConnected = true;
            log('WebSocket connected for user: $userId, shop: $shopId');
            _subscribeToTopic(userId, shopId);
          },
          onDisconnect: (StompFrame frame) {
            _isConnected = false;
            log('WebSocket disconnected');
          },
          onStompError: (StompFrame frame) {
            _isConnected = false;
            final errorBody = frame.body ?? '';
            log('STOMP error: $errorBody');
          },
          onWebSocketError: (dynamic error) {
            _isConnected = false;
            log('WebSocket error: $error');
          },
          stompConnectHeaders: {'Authorization': 'Bearer $token'},
          reconnectDelay: const Duration(seconds: 5),
        ),
      );

      _stompClient!.activate();
    } catch (e) {
      log('Error connecting WebSocket: $e');
      throw Exception('Failed to connect to chat: $e');
    }
  }

  void _subscribeToTopic(String userId, String shopId) {
    if (_stompClient == null || !_isConnected) return;

    final topic = '/topic/chat/$userId/$shopId';
    log('Subscribing to topic: $topic');

    _stompClient!.subscribe(
      destination: topic,
      callback: (StompFrame frame) {
        try {
          if (frame.body == null) return;

          final data = jsonDecode(frame.body!);
          log('Received WebSocket message: $data');

          // Handle CHAT messages
          if (data['type'] == 'CHAT' && data['action'] == 'SEND') {
            if (data['payload'] is Map) {
              // Payload is a ChatMessageModel object
              final payload = data['payload'] as Map<String, dynamic>;
              final message = ChatMessageModel(
                id: payload['id']?.toString(),
                userId: payload['userId']?.toString(),
                userName: payload['userName']?.toString(),
                shopId: payload['shopId']?.toString(),
                shopName: payload['shopName']?.toString(),
                message: payload['message']?.toString(),
                sentBy: payload['sentBy']?.toString(),
                createdAt: payload['createdAt']?.toString(),
                isRead: payload['isRead'] as bool?,
                readAt: payload['readAt']?.toString(),
              );

              _messageController.add(message);
            } else if (data['payload'] is String) {
              // Payload is just a string message
              final message = ChatMessageModel(
                id: null,
                message: data['payload']?.toString(),
                sentBy: data['senderType']?.toString(),
                createdAt: data['timestamp']?.toString(),
                userId: data['senderType'] == 'USER'
                    ? data['senderId']?.toString()
                    : null,
                shopId: data['senderType'] == 'SHOP'
                    ? data['senderId']?.toString()
                    : null,
              );

              _messageController.add(message);
            }
          }
        } catch (e) {
          log('Error parsing WebSocket message: $e');
        }
      },
    );
  }

  @override
  void disconnectWebSocket() {
    try {
      if (_stompClient != null) {
        _stompClient!.deactivate();
        _stompClient = null;
      }
      _isConnected = false;
      log('WebSocket disconnected');
    } catch (e) {
      log('Error disconnecting WebSocket: $e');
    }
  }

  @override
  void sendMessage(String userId, String shopId, ChatMessageModel message) {
    if (_stompClient == null || !_isConnected) {
      throw Exception('WebSocket not connected');
    }

    try {
      final messagePayload = {
        'type': 'CHAT',
        'action': 'SEND',
        'payload': message.message,
        'senderId': userId,
        'senderType': 'USER',
        'recipientId': shopId,
        'timestamp': DateTime.now().toUtc().toIso8601String(),
      };

      final destination = '/app/chat/user/$userId/shop/$shopId';

      _stompClient!.send(
        destination: destination,
        body: jsonEncode(messagePayload),
      );

      log('Message sent via WebSocket to: $destination');
    } catch (e) {
      log('Error sending message via WebSocket: $e');
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  void markAsRead(String userId, String shopId) {
    if (_stompClient == null || !_isConnected) {
      throw Exception('WebSocket not connected');
    }

    try {
      final messagePayload = {
        'type': 'READ_RECEIPT',
        'action': 'READ',
        'senderId': userId,
        'senderType': 'USER',
        'recipientId': shopId,
        'timestamp': DateTime.now().toUtc().toIso8601String(),
      };

      _stompClient!.send(
        destination: '/app/chat/$userId/$shopId/read',
        body: jsonEncode(messagePayload),
      );

      log('Mark as read sent via WebSocket');
    } catch (e) {
      log('Error sending mark as read via WebSocket: $e');
    }
  }

  @override
  void sendTypingIndicator(String userId, String shopId) {
    if (_stompClient == null || !_isConnected) return;

    try {
      final messagePayload = {
        'type': 'TYPING',
        'action': 'TYPING_START',
        'senderId': userId,
        'senderType': 'USER',
        'recipientId': shopId,
        'timestamp': DateTime.now().toUtc().toIso8601String(),
      };

      _stompClient!.send(
        destination: '/app/chat/$userId/$shopId/typing',
        body: jsonEncode(messagePayload),
      );
    } catch (e) {
      log('Error sending typing indicator: $e');
    }
  }

  @override
  void endSession(String userId, String shopId) {
    if (_stompClient == null || !_isConnected) return;

    try {
      _stompClient!.send(
        destination: '/app/chat/$userId/$shopId/end',
        body: '{}',
      );
      
      log('End session sent via WebSocket');
    } catch (e) {
      log('Error ending session via WebSocket: $e');
    }
  }
}
