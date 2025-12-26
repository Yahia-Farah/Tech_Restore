import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../viewmodel/shop_chat_cubit.dart';
import '../../viewmodel/shop_chat_state.dart';
import 'chat_screen.dart';
import '../../../../../core/config/di.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ShopChatCubit>()..fetchSessions(),
      child: const SupportScreenContent(),
    );
  }
}

class SupportScreenContent extends StatelessWidget {
  const SupportScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BlocBuilder<ShopChatCubit, ShopChatState>(
      builder: (context, state) {
        if (state is ShopChatLoading || state is ShopChatInitial) {
          return const Center(child: CircularProgressIndicator(color: Colors.green));
        }
        if (state is ShopSessionsLoaded) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<ShopChatCubit>().fetchSessions();
                await Future.delayed(const Duration(milliseconds: 400));
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            local.supportTitle,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            local.supportSubtitle,
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child:
                          state.sessions.isEmpty
                              ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.chat_bubble_outline,
                                      size: 64,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No chat sessions available',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              : SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Card(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text(local.tableCustomer),
                                        ),
                                        DataColumn(
                                          label: Text(local.tableContent),
                                        ),
                                        DataColumn(
                                          label: Text(local.tableStatus),
                                        ),
                                        DataColumn(
                                          label: Text(local.tableActions),
                                        ),
                                        DataColumn(
                                          label: Text(local.tableRequestId),
                                        ),
                                      ],
                                      rows:
                                          state.sessions
                                              .map(
                                                (session) => DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Text(
                                                        session.userName ?? "",
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        session
                                                                .lastMessage
                                                                ?.content ??
                                                            "",
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(
                                                        session.active == true
                                                            ? local.openStatus
                                                            : local
                                                                .resolvedStatus,
                                                        style: TextStyle(
                                                          color:
                                                              session.active ==
                                                                      true
                                                                  ? Colors.green
                                                                  : Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                    DataCell(
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.chat,
                                                          color: Colors.blue,
                                                        ),
                                                        onPressed: () async {
                                                          await Navigator.of(
                                                            context,
                                                          ).push(
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (
                                                                    _,
                                                                  ) => BlocProvider.value(
                                                                    value: BlocProvider.of<
                                                                      ShopChatCubit
                                                                    >(context),
                                                                    child: ChatScreen(
                                                                      sessionId:
                                                                          session
                                                                              .id!,
                                                                      sessionName:
                                                                          session
                                                                              .userName!,
                                                                      userId:
                                                                          session
                                                                              .userId!,
                                                                      shopId:
                                                                          session
                                                                              .shopId!,
                                                                    ),
                                                                  ),
                                                            ),
                                                          );
                                                          if (context.mounted) {
                                                            context
                                                                .read<
                                                                  ShopChatCubit
                                                                >()
                                                                .fetchSessions();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    DataCell(
                                                      Text(session.id ?? ""),
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                    ),
                                  ),
                                ),
                              ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is ShopChatError) {
          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      state.msg,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ShopChatCubit>().fetchSessions();
                    },
                    child: Text(local.retry),
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
