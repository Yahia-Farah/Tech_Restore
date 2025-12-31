import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/config/di.dart';
import '../viewmodel/user_chat_cubit.dart';
import '../viewmodel/user_chat_state.dart';

class ChatListScreen extends StatelessWidget {
  final Map<String, dynamic>? arguments;

  const ChatListScreen({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserChatCubit>()..fetchMyChatSessions(),
      child: ChatListScreenContent(arguments: arguments),
    );
  }
}

class ChatListScreenContent extends StatelessWidget {
  final Map<String, dynamic>? arguments;

  const ChatListScreenContent({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    final String? shopId = arguments?['shopId'];
    final String? userId = arguments?['userId'];
    final bool isShopSpecific = shopId != null && userId != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        ),
        title: Text(
          isShopSpecific ? "Shop Messages" : "Messages",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserChatCubit>().fetchMyChatSessions();
            },
            icon: Icon(Icons.refresh, color: AppColors.primary),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                hintText: "Search conversations...",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),

          // Chat List
          Expanded(
            child: BlocBuilder<UserChatCubit, UserChatState>(
              builder: (context, state) {
                if (state is UserChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is UserChatError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<UserChatCubit>().fetchMyChatSessions();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: const Text(
                            "Retry",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is UserChatSessionsLoaded) {
                  // Filter sessions by shopId if we're in shop-specific mode
                  final filteredSessions =
                      isShopSpecific
                          ? state.sessions
                              .where((session) => session.shopId == shopId)
                              .toList()
                          : state.sessions;

                  if (filteredSessions.isEmpty) {
                    return _buildEmptyState(
                      context,
                      isShopSpecific,
                      shopId,
                      userId,
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredSessions.length,
                    itemBuilder: (context, index) {
                      final session = filteredSessions[index];
                      return _buildChatItem(context, session);
                    },
                  );
                }

                return _buildEmptyState(
                  context,
                  isShopSpecific,
                  shopId,
                  userId,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton:
          isShopSpecific
              ? FloatingActionButton(
                onPressed: () {
                  _startNewChatWithShop(context, shopId, userId);
                },
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add_comment, color: Colors.white),
              )
              : FloatingActionButton(
                onPressed: () {
                  _showStartChatDialog(context);
                },
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.add_comment, color: Colors.white),
              ),
    );
  }

  Widget _buildEmptyState(
    BuildContext context, [
    bool isShopSpecific = false,
    String? shopId,
    String? userId,
  ]) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            isShopSpecific
                ? "No conversations with this shop yet"
                : "No conversations yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isShopSpecific
                ? "Start a new conversation with this shop"
                : "Start a new conversation or browse shops",
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              if (isShopSpecific && shopId != null && userId != null) {
                _startNewChatWithShop(context, shopId, userId);
              } else {
                _showStartChatDialog(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: Text(
              isShopSpecific ? "Start Chat with Shop" : "Start New Chat",
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatItem(BuildContext context, dynamic session) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: 28,
              child: Text(
                session.shopName?.substring(0, 1).toUpperCase() ?? "S",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            if (session.active == true)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          session.shopName ?? "Unknown Shop",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            session.lastMessage?.message ?? "No messages yet",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              _formatTime(session.lastMessage?.createdAt),
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: session.active == true ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                session.active == true ? "Active" : "Closed",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.chat,
            arguments: {
              "sessionId": session.id,
              "shopId": session.shopId,
              "userId": session.userId,
              "shopName": session.shopName,
              "userName": session.userName,
              "active": session.active,
            },
          );
        },
      ),
    );
  }

  String _formatTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(dateTimeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return dateTimeString.length > 16
          ? dateTimeString.substring(11, 16)
          : dateTimeString;
    }
  }

  void _startNewChatWithShop(
    BuildContext context,
    String? shopId,
    String? userId,
  ) async {
    if (shopId == null || userId == null) return;

    try {
      // Get shop name from explore cubit if available, or use a default
      String shopName = "Shop";

      // Navigate directly to chat screen to start a new session
      Navigator.pushNamed(
        context,
        AppRoutes.chat,
        arguments: {
          "sessionId": null, // New session
          "shopId": shopId,
          "userId": userId,
          "shopName": shopName,
          "userName": "User",
          "active": true,
        },
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to start chat: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showStartChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.chat, color: AppColors.primary, size: 32),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Start New Conversation",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Choose a shop to start chatting",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: AppColors.primary),
                      hintText: "Search shops...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                          child: const Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Handle start chat
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Start Chat",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
