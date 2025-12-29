import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../viewmodel/shop_chat_cubit.dart';
import '../../viewmodel/shop_chat_state.dart';
import '../../../data/models/chats/chat_message_model.dart';

class ChatScreen extends StatefulWidget {
  final String sessionId;
  final String sessionName;
  final String userId;
  final String shopId;

  const ChatScreen({
    required this.sessionId,
    required this.sessionName,
    required this.userId,
    required this.shopId,
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late ShopChatCubit _cubit;
  static const String shopName = 'Tech Restore Shop';
  bool _isWebSocketConnected = false;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ShopChatCubit>();
    _cubit.fetchMessages(widget.sessionId);
    _connectWebSocket();
  }

  void _connectWebSocket() async {
    await _cubit.connectWebSocket(widget.userId, widget.shopId);
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      setState(() {
        _isWebSocketConnected = true;
      });
    }
  }

  @override
  void dispose() {
    _cubit.disconnectWebSocket();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final local = AppLocalizations.of(context)!;
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    if (!_isWebSocketConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(local.connecting),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    final message = ChatMessageModel(
      sessionId: widget.sessionId,
      sentBy: 'SHOP',
      senderName: shopName,
      senderType: 'SHOP',
      message: content,
      content: content,
      createdAt: DateTime.now().toIso8601String(),
    );

    _cubit.sendMessage(
      widget.userId,
      widget.shopId,
      message,
      useWebSocket: true,
    );
    _messageController.clear();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _formatTime(String? dateTimeString, Locale locale) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final hour = dateTime.hour;
      final minute = dateTime.minute;

      if (locale.languageCode == 'ar') {
        final period = hour >= 12 ? 'م' : 'ص';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        String hourStr = _toArabicNumerals(displayHour.toString());
        String minuteStr = _toArabicNumerals(minute.toString().padLeft(2, '0'));
        return '$hourStr:$minuteStr $period';
      } else {
        final period = hour >= 12 ? 'PM' : 'AM';
        final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
        return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
      }
    } catch (e) {
      return dateTimeString.length > 16
          ? dateTimeString.substring(11, 16)
          : dateTimeString;
    }
  }

  String _toArabicNumerals(String number) {
    const arabicNumerals = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.split('').map((digit) {
      if (digit == ' ') return ' ';
      final index = int.tryParse(digit);
      return index != null ? arabicNumerals[index] : digit;
    }).join();
  }

  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return '';
    return name.substring(0, 1).toUpperCase();
  }

  bool _isShopMessage(ChatMessageModel message) {
    final senderType = message.displaySenderType;
    return senderType == 'SHOP' ||
        senderType == 'shop' ||
        message.displaySenderName == shopName;
  }

  String _getLocalizedMessage(String key, AppLocalizations local) {
    switch (key) {
      case 'websocketNotConnected':
        return local.websocketNotConnected;
      case 'websocketDisconnected':
        return local.websocketDisconnected;
      case 'websocketError':
        return local.websocketError;
      case 'websocketConnectionError':
        return local.websocketConnectionError;
      case 'websocketConnectionFailed':
        return local.websocketConnectionFailed;
      case 'failedToSendMessage':
        return local.failedToSendMessage;
      case 'authenticationTokenRequired':
        return local.authenticationTokenRequired;
      case 'chatEndedSuccessfully':
        return local.chatEndedSuccessfully;
      default:
        return key;
    }
  }

  Widget _buildAvatar(String? name, bool isShop) {
    return CircleAvatar(
      radius: 20,
      backgroundColor:
          isShop ? const Color(0xFFDCFFD6) : const Color(0xFFE8F5E9),
      child: Text(
        _getInitials(name),
        style: TextStyle(
          color: isShop ? const Color(0xFF4CAF50) : const Color(0xFF66BB6A),
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildMessageBubble(
    ChatMessageModel message,
    bool isShop,
    Locale locale,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisAlignment:
            isShop ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isShop) _buildAvatar(message.displaySenderName, false),
          if (!isShop) const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isShop ? const Color(0xFF4CAF50) : Colors.white,
                border:
                    isShop
                        ? null
                        : Border.all(
                          color: const Color(0xFFDCFFD6),
                          width: 1.5,
                        ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.displaySenderName ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: isShop ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message.displayContent ?? '',
                    style: TextStyle(
                      fontSize: 15,
                      color: isShop ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.createdAt, locale),
                    style: TextStyle(
                      fontSize: 11,
                      color: isShop ? Colors.white70 : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isShop) const SizedBox(width: 8),
          if (isShop) _buildAvatar(message.displaySenderName, true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Image.asset(AppIcons.arrowBack, color: AppColors.white),
          ),
          backgroundColor: const Color(0xFF4CAF50),
          elevation: 0,
          title: Column(
            crossAxisAlignment:
                isRTL ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment:
                    isRTL ? MainAxisAlignment.end : MainAxisAlignment.start,
                children:
                    isRTL
                        ? [
                          Text(
                            widget.sessionName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            local.chatWith,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ]
                        : [
                          Text(
                            local.chatWith,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.sessionName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(
                right: isRTL ? 16 : 0,
                left: isRTL ? 0 : 16,
              ),
              child: Row(
                mainAxisAlignment:
                    isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF66BB6A),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    local.connected,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed:
                  () => _cubit.endSession(
                    widget.userId,
                    widget.shopId,
                    sessionId: widget.sessionId,
                  ),
              tooltip: local.endChat,
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ShopChatCubit, ShopChatState>(
                builder: (context, state) {
                  if (state is ShopChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is ShopMessagesLoaded) {
                    if (state.messages.isEmpty) {
                      return Center(
                        child: Text(
                          local.noMessages,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });

                    return ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        final isShop = _isShopMessage(message);
                        return _buildMessageBubble(message, isShop, locale);
                      },
                    );
                  }

                  if (state is ShopChatError || state is ShopChatActionError) {
                    final errorKey =
                        state is ShopChatError
                            ? state.msg
                            : (state as ShopChatActionError).msg;
                    final errorMsg = _getLocalizedMessage(errorKey, local);
                    return Center(
                      child: Text(
                        errorMsg,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  if (state is ShopChatActionSuccess) {
                    Future.microtask(() => Navigator.of(context).pop());
                    final successMsg = _getLocalizedMessage(
                      state.message,
                      local,
                    );
                    return Center(
                      child: Text(
                        successMsg,
                        style: const TextStyle(color: Colors.green),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFDCFFD6),
                border: Border(
                  top: BorderSide(
                    color: const Color(0xFFDCFFD6).withOpacity(0.3),
                    width: 1,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                children:
                    isRTL
                        ? [
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  _isWebSocketConnected
                                      ? const Color(0xFF4CAF50)
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:
                                    _isWebSocketConnected ? _sendMessage : null,
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        local.send,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFDCFFD6),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  hintText: local.typeMessage,
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                textDirection: TextDirection.ltr,
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                          ),
                        ]
                        : [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFDCFFD6),
                                  width: 1,
                                ),
                              ),
                              child: TextField(
                                controller: _messageController,
                                decoration: InputDecoration(
                                  hintText: local.typeMessage,
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                ),
                                textDirection: TextDirection.rtl,
                                onSubmitted: (_) => _sendMessage(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  _isWebSocketConnected
                                      ? const Color(0xFF4CAF50)
                                      : Colors.grey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap:
                                    _isWebSocketConnected ? _sendMessage : null,
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.send,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        local.send,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
