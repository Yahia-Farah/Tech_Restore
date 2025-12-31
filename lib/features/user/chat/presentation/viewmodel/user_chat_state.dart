import 'package:equatable/equatable.dart';
import '../../data/models/chat_message_model.dart';
import '../../data/models/chat_session_model.dart';

abstract class UserChatState extends Equatable {
  const UserChatState();

  @override
  List<Object?> get props => [];
}

class UserChatInitial extends UserChatState {}

class UserChatLoading extends UserChatState {}

class UserChatSessionsLoaded extends UserChatState {
  final List<ChatSessionModel> sessions;

  const UserChatSessionsLoaded(this.sessions);

  @override
  List<Object?> get props => [sessions];
}

class UserChatMessagesLoaded extends UserChatState {
  final List<ChatMessageModel> messages;

  const UserChatMessagesLoaded(this.messages);

  @override
  List<Object?> get props => [messages];
}

class UserChatWebSocketConnected extends UserChatState {
  final String userId;
  final String shopId;

  const UserChatWebSocketConnected(this.userId, this.shopId);

  @override
  List<Object?> get props => [userId, shopId];
}

class UserChatWebSocketDisconnected extends UserChatState {}

class UserChatMessageReceived extends UserChatState {
  final ChatMessageModel message;

  const UserChatMessageReceived(this.message);

  @override
  List<Object?> get props => [message];
}

class UserChatMessageSent extends UserChatState {
  final ChatMessageModel message;

  const UserChatMessageSent(this.message);

  @override
  List<Object?> get props => [message];
}

class UserChatTypingIndicator extends UserChatState {
  final String userId;
  final String shopId;
  final bool isTyping;

  const UserChatTypingIndicator(this.userId, this.shopId, this.isTyping);

  @override
  List<Object?> get props => [userId, shopId, isTyping];
}

class UserChatSessionClosed extends UserChatState {
  final String message;

  const UserChatSessionClosed(this.message);

  @override
  List<Object?> get props => [message];
}

class UserChatError extends UserChatState {
  final String message;

  const UserChatError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserChatActionSuccess extends UserChatState {
  final String message;

  const UserChatActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class UserChatUnreadCountLoaded extends UserChatState {
  final int unreadCount;

  const UserChatUnreadCountLoaded(this.unreadCount);

  @override
  List<Object?> get props => [unreadCount];
}
