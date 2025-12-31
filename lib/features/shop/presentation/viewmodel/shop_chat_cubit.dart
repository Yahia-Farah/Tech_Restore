import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tech_restore/features/auth/domain/services/auth_services.dart';
import 'package:tech_restore/features/shop/data/models/chats/chat_message_model.dart';
import 'package:tech_restore/features/shop/presentation/viewmodel/shop_chat_state.dart';
import '../../../../core/api/api_constants/api_constants.dart';
import '../../data/repositories/shop_repository.dart';

@injectable
class ShopChatCubit extends Cubit<ShopChatState> {
  final ShopRepository _repository;
  StompClient? _stompClient;
  List<ChatMessageModel> _messages = [];
  bool _isConnected = false;
  String? _currentUserId;
  String? _currentShopId;
  String? _shopId;

  ShopChatCubit(this._repository) : super(ShopChatInitial());

  Future<void> fetchSessions() async {
    emit(ShopChatLoading());
    try {
      final sessions = await _repository.getChatSessions();
      emit(ShopSessionsLoaded(sessions));
    } catch (e) {
      final errorString = e.toString();
      if (errorString.contains('404') || errorString.contains('not found')) {
        emit(ShopSessionsLoaded([]));
      } else if (errorString.contains('500') ||
          errorString.contains('RUNTIME_ERROR')) {
        // Handle backend data issues gracefully
        emit(
          ShopChatError(
            'Backend data issue detected. Please contact support or try again later.',
          ),
        );
      } else {
        emit(ShopChatError(e.toString()));
      }
    }
  }

  Future<void> fetchMessages(String sessionId) async {
    emit(ShopChatLoading());
    try {
      final List<ChatMessageModel> messages = await _repository.getChatMessages(
        sessionId,
      );
      _messages = messages;
      emit(ShopMessagesLoaded(List.from(_messages)));
    } catch (e) {
      final errorString = e.toString();
      if (errorString.contains('500') ||
          errorString.contains('RUNTIME_ERROR')) {
        // Handle backend data issues gracefully
        emit(
          ShopChatError(
            'Backend data issue detected. Please contact support or try again later.',
          ),
        );
      } else {
        emit(ShopChatError(e.toString()));
      }
    }
  }

  Future<void> sendMessage(
    String userId,
    String shopId,
    ChatMessageModel message, {
    bool useWebSocket = true,
  }) async {
    if (_stompClient != null && _isConnected) {
      sendStompMessage(userId, shopId, message);
    } else {
      emit(ShopChatError('websocketNotConnected'));
    }
  }

  Future<void> connectWebSocket(String userId, String shopId) async {
    try {
      await disconnectWebSocket();

      final token = await AuthService.getToken();

      if (token == null || token.isEmpty) {
        throw Exception('authenticationTokenRequired');
      }

      _currentUserId = userId;
      _currentShopId = shopId;
      _shopId = shopId;

      final baseUrl = ApiConstant.baseUrl.replaceAll('/api/', '');
      final wsUrl = '$baseUrl/ws';

      _stompClient = StompClient(
        config: StompConfig.sockJS(
          url: wsUrl,
          onConnect: (StompFrame frame) {
            _isConnected = true;
            _subscribeToTopics(userId, shopId);
          },
          onDisconnect: (StompFrame frame) {
            _isConnected = false;
          },
          onStompError: (StompFrame frame) {
            _isConnected = false;
            final errorBody = frame.body ?? '';
            if (errorBody.contains('401') ||
                errorBody.contains('Unauthorized') ||
                frame.headers.containsKey('message')) {
              final errorMsg =
                  frame.headers['message'] ?? frame.body ?? 'Unauthorized';
              emit(ShopChatError('websocketError: $errorMsg'));
            } else {
              emit(
                ShopChatError(
                  'websocketError: ${frame.body ?? "Unknown error"}',
                ),
              );
            }
          },
          onWebSocketError: (dynamic error) {
            _isConnected = false;
            emit(
              ShopChatError('websocketConnectionError: ${error.toString()}'),
            );
          },
          stompConnectHeaders: {'Authorization': 'Bearer $token'},
          reconnectDelay: const Duration(seconds: 5),
        ),
      );

      _stompClient!.activate();
    } catch (e) {
      emit(ShopChatError('websocketConnectionFailed: ${e.toString()}'));
      _isConnected = false;
    }
  }

  void _subscribeToTopics(String userId, String shopId) async {
    if (_stompClient == null || !_isConnected) return;

    final topic = '/topic/chat/$userId/$shopId';

    _stompClient!.subscribe(
      destination: topic,
      callback: (StompFrame frame) {
        try {
          final data = jsonDecode(frame.body!);

          if (data['type'] == 'CHAT' && data['action'] == 'SEND') {
            if (data['payload'] is Map) {
              final payload = data['payload'] as Map<String, dynamic>;
              final msg = ChatMessageModel(
                id: payload['id']?.toString(),
                sessionId: null,
                userId: payload['userId']?.toString(),
                userName: payload['userName']?.toString(),
                shopId: payload['shopId']?.toString(),
                shopName: payload['shopName']?.toString(),
                message: payload['message']?.toString(),
                sentBy: payload['sentBy']?.toString(),
                senderId:
                    payload['sentBy'] == 'USER'
                        ? payload['userId']?.toString()
                        : payload['shopId']?.toString(),
                senderType: payload['sentBy']?.toString(),
                senderName:
                    payload['sentBy'] == 'USER'
                        ? payload['userName']?.toString()
                        : payload['shopName']?.toString(),
                createdAt: payload['createdAt']?.toString(),
                isRead: payload['isRead'] as bool?,
                readAt: payload['readAt']?.toString(),
              );

              if (!_messages.any((m) => m.id == msg.id && m.id != null)) {
                _messages.add(msg);
                emit(ShopMessagesLoaded(List.from(_messages)));
              }
            } else if (data['payload'] is String) {
              final msg = ChatMessageModel(
                id: null,
                sessionId: null,
                message: data['payload']?.toString(),
                senderId: data['senderId']?.toString(),
                senderType: data['senderType']?.toString(),
                createdAt: data['timestamp']?.toString(),
              );

              _messages.add(msg);
              emit(ShopMessagesLoaded(List.from(_messages)));
            }
          } else if (data['type'] == 'ERROR') {
            emit(
              ShopChatError(data['message']?.toString() ?? 'websocketError'),
            );
          }
        } catch (e) {}
      },
    );
  }

  void sendStompMessage(
    String userId,
    String shopId,
    ChatMessageModel message,
  ) async {
    if (_stompClient == null || !_isConnected) {
      emit(ShopChatError('websocketNotConnected'));
      return;
    }

    try {
      final messagePayload = {
        'type': 'CHAT',
        'action': 'SEND',
        'payload': message.displayContent ?? message.content,
        'senderId': shopId,
        'senderType': 'SHOP',
        'recipientId': userId,
        'timestamp': DateTime.now().toUtc().toIso8601String(),
      };

      final destination = '/app/chat/user/$userId/shop/$shopId';

      _stompClient!.send(
        destination: destination,
        body: jsonEncode(messagePayload),
      );

      final optimisticMessage = ChatMessageModel(
        id: message.id,
        sessionId: null,
        shopId: shopId,
        sentBy: 'SHOP',
        senderId: shopId,
        senderType: 'SHOP',
        senderName: message.displaySenderName ?? message.senderName,
        message: message.displayContent ?? message.content,
        content: message.displayContent ?? message.content,
        createdAt: message.createdAt ?? DateTime.now().toIso8601String(),
      );
      _messages.add(optimisticMessage);
      emit(ShopMessagesLoaded(List.from(_messages)));
    } catch (e) {
      emit(ShopChatError('failedToSendMessage'));
    }
  }

  Future<void> disconnectWebSocket() async {
    if (_stompClient != null) {
      _stompClient!.deactivate();
      _stompClient = null;
    }
    _isConnected = false;
    _currentUserId = null;
    _currentShopId = null;
  }

  Future<void> endSession(
    String userId,
    String shopId, {
    String? sessionId,
  }) async {
    if (_stompClient != null && _isConnected) {
      try {
        final endPayload = {};

        _stompClient!.send(
          destination: '/app/chat/$userId/$shopId/end',
          body: jsonEncode(endPayload),
        );

        await Future.delayed(const Duration(milliseconds: 500));
        emit(ShopChatActionSuccess('chatEndedSuccessfully'));
      } catch (e) {
        emit(ShopChatError(e.toString()));
      }
    } else {
      emit(ShopChatLoading());
      try {
        if (sessionId != null) {
          await _repository.endChatSession(sessionId);
        }
        emit(ShopChatActionSuccess('chatEndedSuccessfully'));
      } catch (e) {
        emit(ShopChatError(e.toString()));
      }
    }
  }
}
