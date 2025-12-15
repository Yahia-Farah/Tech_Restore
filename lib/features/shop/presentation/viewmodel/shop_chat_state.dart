import '../../data/models/chats/chat_session_model.dart' hide ChatMessageModel;
import '../../data/models/chats/chat_message_model.dart';

abstract class ShopChatState {}

class ShopChatInitial extends ShopChatState {}
class ShopChatLoading extends ShopChatState {}

class ShopSessionsLoaded extends ShopChatState {
  final List<ChatSessionModel> sessions;
  final bool lastPage;
  ShopSessionsLoaded(this.sessions, {this.lastPage = false});
}

class ShopMessagesLoaded extends ShopChatState {
  final List<ChatMessageModel> messages;
  ShopMessagesLoaded(this.messages);
}

class ShopChatError extends ShopChatState {
  final String msg;
  ShopChatError(this.msg);
}

class ShopChatActionLoading extends ShopChatState {}
class ShopChatActionSuccess extends ShopChatState {
  final String message;
  ShopChatActionSuccess(this.message);
}
class ShopChatActionError extends ShopChatState {
  final String msg;
  ShopChatActionError(this.msg);
}


