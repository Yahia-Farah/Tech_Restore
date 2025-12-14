import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';
import 'package:tech_restore/features/auth/domain/services/auth_services.dart';
import 'package:tech_restore/features/shop/data/models/chats/chat_message_model.dart';
import 'package:tech_restore/features/shop/presentation/viewmodel/shop_chat_state.dart';
import '../../data/repositories/shop_repository.dart';

@injectable
class ShopChatCubit extends Cubit<ShopChatState> {
  final ShopRepository _repository;
  StompClient? _stompClient;
  List<ChatMessageModel> _messages = [];
  bool _isConnected = false;
  String? _currentSessionId;
  String? _shopEmail;

  ShopChatCubit(this._repository) : super(ShopChatInitial());

  Future<void> fetchSessions() async {
    emit(ShopChatLoading());
    try {
      final sessions = await _repository.getChatSessions();
      emit(ShopSessionsLoaded(sessions));
    } catch (e) {
      emit(ShopChatError(e.toString()));
    }
  }

  Future<void> fetchMessages(String sessionId) async {
    emit(ShopChatLoading());
    try {
      final List<ChatMessageModel> messages = await _repository.getChatMessages(sessionId);
      _messages = messages;
      emit(ShopMessagesLoaded(List.from(_messages)));
    } catch (e) {
      emit(ShopChatError(e.toString()));
    }
  }

  Future<void> sendMessage(String sessionId, ChatMessageModel message, {bool useWebSocket = true}) async {
    if (_stompClient != null && _isConnected) {
      sendStompMessage(message);
    } else {
      emit(ShopChatError('websocketNotConnected'));
    }
  }

  Future<void> connectWebSocket(String sessionId) async {
    try {
      await disconnectWebSocket();
      
      final token = await AuthService.getToken();
      
      if (token == null || token.isEmpty) {
        throw Exception('authenticationTokenRequired');
      }
      
      _shopEmail = 'Tech Restore Shop';
      _currentSessionId = sessionId;
      
      final baseUrl = 'http://10.0.2.2:8080';
      final wsUrl = '$baseUrl/ws';
      
      _stompClient = StompClient(
        config: StompConfig.sockJS(
          url: wsUrl,
          onConnect: (StompFrame frame) {
            _isConnected = true;
            _subscribeToTopics(sessionId);
          },
          onDisconnect: (StompFrame frame) {
            _isConnected = false;
          },
          onStompError: (StompFrame frame) {
            _isConnected = false;
            emit(ShopChatError('websocketError'));
          },
          onWebSocketError: (dynamic error) {
            _isConnected = false;
            emit(ShopChatError('websocketConnectionError'));
          },
          stompConnectHeaders: {
            'Authorization': 'Bearer $token',
          },
          webSocketConnectHeaders: {
            'Authorization': 'Bearer $token',
          },
          reconnectDelay: const Duration(seconds: 5),
        ),
      );
      
      _stompClient!.activate();
    } catch (e) {
      emit(ShopChatError('websocketConnectionFailed'));
      _isConnected = false;
    }
  }
  
  void _subscribeToTopics(String sessionId) async {
    if (_stompClient == null || !_isConnected || _shopEmail == null) return;
    
    final token = await AuthService.getToken();
    
    _stompClient!.subscribe(
      destination: '/topic/chat/$sessionId',
      callback: (StompFrame frame) {
        try {
          final data = jsonDecode(frame.body!);
          final msg = ChatMessageModel.fromJson(data);
          
          if (!_messages.any((m) => m.id == msg.id && m.id != null)) {
            _messages.add(msg);
            emit(ShopMessagesLoaded(List.from(_messages)));
          }
        } catch (e) {
        }
      },
    );
    
    _stompClient!.subscribe(
      destination: '/user/$_shopEmail/queue/chat/messages/$sessionId',
      callback: (StompFrame frame) {
        try {
          final data = jsonDecode(frame.body!);
          final msg = ChatMessageModel.fromJson(data);
          
          if (!_messages.any((m) => m.id == msg.id && m.id != null)) {
            _messages.add(msg);
            emit(ShopMessagesLoaded(List.from(_messages)));
          }
        } catch (e) {
        }
      },
      headers: token != null ? {
        'Authorization': 'Bearer $token',
      } : {},
    );
  }

  void sendStompMessage(ChatMessageModel message) async {
    if (_stompClient == null || !_isConnected) {
      emit(ShopChatError('websocketNotConnected'));
      return;
    }
    
    try {
      final token = await AuthService.getToken();
      
      final messagePayload = {
        'id': message.id,
        'sessionId': message.sessionId,
        'content': message.content,
        'senderType': message.senderType ?? 'SHOP',
        'senderName': message.senderName,
        'createdAt': message.createdAt ?? DateTime.now().toIso8601String(),
      };
      
      _stompClient!.send(
        destination: '/app/chat/send',
        body: jsonEncode(messagePayload),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      
      final optimisticMessage = ChatMessageModel(
        id: message.id,
        sessionId: message.sessionId,
        senderId: message.senderId,
        senderType: message.senderType ?? 'SHOP',
        senderName: message.senderName,
        content: message.content,
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
    _currentSessionId = null;
  }

  Future<void> endSession(String sessionId) async {
    emit(ShopChatLoading());
    try {
      await _repository.endChatSession(sessionId);
      emit(ShopChatActionSuccess('chatEndedSuccessfully'));
    } catch (e) {
      emit(ShopChatError(e.toString()));
    }
  }
}

