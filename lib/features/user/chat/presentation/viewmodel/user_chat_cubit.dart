import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/repositories/user_chat_repository.dart';
import 'user_chat_state.dart';

@injectable
class UserChatCubit extends Cubit<UserChatState> {
  final UserChatRepository _repository;
  StreamSubscription? _webSocketSubscription;
  List<ChatMessageModel> _currentMessages = [];

  UserChatCubit(this._repository) : super(UserChatInitial());

  // Fetch user's chat sessions
  Future<void> fetchMyChatSessions() async {
    try {
      emit(UserChatLoading());
      final sessions = await _repository.getMyChatSessions();
      emit(UserChatSessionsLoaded(sessions));
    } catch (e) {
      log('Error fetching chat sessions: $e');
      emit(UserChatError('Failed to load chat sessions: $e'));
    }
  }

  // Fetch messages for a specific chat
  Future<void> fetchMessages(String userId, String shopId) async {
    try {
      emit(UserChatLoading());
      final messages = await _repository.getChatMessages(userId, shopId);
      _currentMessages = messages;
      emit(UserChatMessagesLoaded(messages));
    } catch (e) {
      log('Error fetching messages: $e');
      // If it's a session not found error, just emit empty messages
      // The WebSocket connection will create the session
      if (e.toString().contains('Chat session not found') ||
          e.toString().contains('RUNTIME_ERROR')) {
        log('Session not found, starting with empty messages');
        _currentMessages = [];
        emit(UserChatMessagesLoaded([]));
      } else {
        emit(UserChatError('Failed to load messages: $e'));
      }
    }
  }

  // Connect to WebSocket
  Future<void> connectWebSocket(String userId, String shopId) async {
    try {
      await _repository.connectWebSocket(userId, shopId);

      // Listen to WebSocket messages (now directly ChatMessageModel)
      _webSocketSubscription = _repository.messageStream?.listen(
        (message) {
          // Check for validation: Prevent duplicates if message already exists
          if (!_currentMessages.any(
            (m) => m.id == message.id && m.id != null,
          )) {
            _currentMessages.add(message);
            emit(UserChatMessagesLoaded(List.from(_currentMessages)));
            emit(UserChatMessageReceived(message));
          }
        },
        onError: (error) {
          log('WebSocket error: $error');
          emit(UserChatError('Connection error: $error'));
        },
        onDone: () {
          log('WebSocket connection closed');
          emit(UserChatWebSocketDisconnected());
        },
      );

      emit(UserChatWebSocketConnected(userId, shopId));
    } catch (e) {
      log('Error connecting WebSocket: $e');
      emit(UserChatError('Failed to connect: $e'));
    }
  }

  // Send a message
  Future<void> sendMessage(
    String userId,
    String shopId,
    ChatMessageModel message, {
    bool useWebSocket = true,
  }) async {
    try {
      if (useWebSocket) {
        _repository.sendMessage(userId, shopId, message);
      } else {
        // Fallback to REST API if needed
        // You can implement REST API message sending here
        emit(UserChatError('REST API message sending not implemented'));
      }
    } catch (e) {
      log('Error sending message: $e');
      emit(UserChatError('Failed to send message: $e'));
    }
  }

  // Mark messages as read
  Future<void> markMessagesAsRead(
    String userId,
    String shopId, {
    bool useWebSocket = true,
  }) async {
    try {
      if (useWebSocket) {
        _repository.markAsRead(userId, shopId);
      } else {
        await _repository.markMessagesAsRead(userId, shopId);
      }
      emit(UserChatActionSuccess('Messages marked as read'));
    } catch (e) {
      log('Error marking messages as read: $e');
      emit(UserChatError('Failed to mark messages as read: $e'));
    }
  }

  // Send typing indicator
  void sendTypingIndicator(String userId, String shopId) {
    try {
      _repository.sendTypingIndicator(userId, shopId);
    } catch (e) {
      log('Error sending typing indicator: $e');
    }
  }

  // End chat session
  Future<void> endSession(
    String userId,
    String shopId, {
    String? sessionId,
  }) async {
    try {
      _repository.endSession(userId, shopId);

      // Also close via REST API
      await _repository.closeChatSession(userId, shopId);

      emit(UserChatActionSuccess('Chat session ended successfully'));
    } catch (e) {
      log('Error ending session: $e');
      emit(UserChatError('Failed to end session: $e'));
    }
  }

  // Get unread message count
  Future<void> getUnreadMessageCount(String userId) async {
    try {
      final result = await _repository.getUnreadMessageCount(userId);
      emit(UserChatUnreadCountLoaded(result['unreadCount'] ?? 0));
    } catch (e) {
      log('Error getting unread count: $e');
      emit(UserChatError('Failed to get unread count: $e'));
    }
  }

  // Disconnect WebSocket
  void disconnectWebSocket() {
    try {
      _webSocketSubscription?.cancel();
      _webSocketSubscription = null;
      _repository.disconnectWebSocket();
      emit(UserChatWebSocketDisconnected());
    } catch (e) {
      log('Error disconnecting WebSocket: $e');
    }
  }

  @override
  Future<void> close() {
    disconnectWebSocket();
    return super.close();
  }
}
