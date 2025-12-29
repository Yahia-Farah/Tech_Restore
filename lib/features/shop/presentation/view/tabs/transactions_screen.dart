import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/config/di.dart';
import '../../../data/repositories/shop_repository.dart';
import '../../../data/models/transactions/financial_report_model.dart';
import '../../viewmodel/transactions_cubit.dart';
import '../../viewmodel/transactions_state.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionsCubit(getIt<ShopRepository>())
        ..loadFinancialReport(isRefresh: true),
      child: const TransactionsScreenContent(),
    );
  }
}

class TransactionsScreenContent extends StatefulWidget {
  const TransactionsScreenContent({super.key});

  @override
  State<TransactionsScreenContent> createState() => _TransactionsScreenContentState();
}

class _TransactionsScreenContentState extends State<TransactionsScreenContent> {
  String _searchQuery = "";
  int _currentPage = 1;
  final int _rowsPerPage = 5;
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  bool _isScrollingRight = true;
  bool _isUserScrolling = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _startAutoScroll();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text;
        _currentPage = 1;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // Detect user interaction
    if (_scrollController.position.isScrollingNotifier.value) {
      if (!_isUserScrolling) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      }
    }
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();

    // Add a small delay before starting auto-scroll
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted || !_scrollController.hasClients) return;

      _scrollTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        if (!_scrollController.hasClients || _isUserScrolling || !mounted) return;

        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        if (maxScroll <= 0) return; // No scrolling needed if content fits

        double targetScroll;
        const scrollSpeed = 1.0;

        if (_isScrollingRight) {
          if (currentScroll >= maxScroll) {
            _isScrollingRight = false;
            targetScroll = currentScroll - scrollSpeed;
          } else {
            targetScroll = currentScroll + scrollSpeed;
          }
        } else {
          if (currentScroll <= 0) {
            _isScrollingRight = true;
            targetScroll = currentScroll + scrollSpeed;
          } else {
            targetScroll = currentScroll - scrollSpeed;
          }
        }

        _scrollController.jumpTo(targetScroll.clamp(0.0, maxScroll));
      });
    });
  }

  String _getCurrency(AppLocalizations local) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? 'ج.م' : 'EGP';
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final currency = _getCurrency(local);

    return BlocConsumer<TransactionsCubit, TransactionsState>(
      listener: (context, state) {
        if (state is TransactionsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<TransactionsCubit>();
        final filteredTransactions = cubit.getFilteredTransactions(_searchQuery);

        final totalPages = filteredTransactions.isEmpty ? 1 : (filteredTransactions.length / _rowsPerPage).ceil();
        final startIndex = (_currentPage - 1) * _rowsPerPage;
        final endIndex = (_currentPage * _rowsPerPage).clamp(0, filteredTransactions.length);
        final currentPageItems = filteredTransactions.isEmpty
            ? <TransactionModel>[]
            : filteredTransactions.sublist(startIndex, endIndex);

        return RefreshIndicator(
          onRefresh: () async {
            await cubit.loadFinancialReport(isRefresh: true);
          },
          color: Colors.green,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
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
                        local.transactions_title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        local.transactions_subtitle,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Summary Cards with Auto-Scroll
                _buildSummaryCards(local, currency, cubit),
                const SizedBox(height: 20),

                // Search
                CustomTextFormField(
                  controller: _searchController,
                  hint: local.search_hint_transactions,
                ),
                const SizedBox(height: 20),

                // Table with Pagination
                _buildTransactionsTable(local, currency, currentPageItems, state, filteredTransactions, totalPages, startIndex, endIndex),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryCards(AppLocalizations local, String currency, TransactionsCubit cubit) {
    return GestureDetector(
      onPanStart: (_) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      },
      onPanEnd: (_) {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 3), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      },
      onPanCancel: () {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 3), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      },
      onTap: () {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
        Future.delayed(const Duration(seconds: 3), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Row(
          children: [
            _buildSummaryCard(
              local.total_profits,
              "${cubit.totalProfit.toStringAsFixed(2)} $currency",
              Colors.blue,
            ),
            _buildSummaryCard(
              "Sales Revenue",
              "${cubit.totalSalesRevenue.toStringAsFixed(2)} $currency",
              Colors.green,
            ),
            _buildSummaryCard(
              "Repair Revenue",
              "${cubit.totalRepairRevenue.toStringAsFixed(2)} $currency",
              Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsTable(
      AppLocalizations local,
      String currency,
      List<TransactionModel> currentPageItems,
      TransactionsState state,
      List<TransactionModel> filteredTransactions,
      int totalPages,
      int startIndex,
      int endIndex,
      ) {
    if (state is TransactionsLoading && context.read<TransactionsCubit>().transactions.isEmpty) {
      return Card(
        child: SizedBox(
          height: 300,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.green),
          ),
        ),
      );
    }

    return Card(
      child: Column(
        children: [
          // Transactions Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text(local.date)),
                DataColumn(label: Text(local.service_type)),
                DataColumn(label: Text(local.device)),
                DataColumn(label: Text(local.shop)),
                DataColumn(label: Text(local.payment_method)),
                DataColumn(label: Text(local.amount)),
                DataColumn(label: Text(local.status)),
              ],
              rows: currentPageItems.isEmpty
                  ? []
                  : currentPageItems.map((transaction) => _buildTransactionRow(
                transaction,
                local,
                currency,
                context.read<TransactionsCubit>(),
              )).toList(),
            ),
          ),

          // Empty State
          if (currentPageItems.isEmpty && state is! TransactionsLoading)
            Container(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _searchQuery.isNotEmpty
                        ? 'No transactions found matching "$_searchQuery"'
                        : 'No transactions found',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

          // Pagination
          if (filteredTransactions.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredTransactions.length} ${local.transactions}",
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _currentPage > 1
                            ? () => setState(() => _currentPage--)
                            : null,
                      ),
                      for (int i = 1; i <= totalPages; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _currentPage == i
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                              foregroundColor: _currentPage == i
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            onPressed: () => setState(() => _currentPage = i),
                            child: Text("$i"),
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _currentPage < totalPages
                            ? () => setState(() => _currentPage++)
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  DataRow _buildTransactionRow(
      TransactionModel transaction,
      AppLocalizations local,
      String currency,
      TransactionsCubit cubit,
      ) {
    Color statusColor;
    String statusLabel;

    switch (transaction.paymentStatus?.toUpperCase()) {
      case "COMPLETED":
        statusColor = Colors.green;
        statusLabel = local.completed;
        break;
      case "PENDING":
        statusColor = Colors.orange;
        statusLabel = local.pending;
        break;
      case "FAILED":
        statusColor = Colors.red;
        statusLabel = local.failed;
        break;
      default:
        statusColor = Colors.grey;
        statusLabel = transaction.paymentStatus ?? 'Unknown';
    }

    return DataRow(
      cells: [
        DataCell(Text(_formatDate(transaction.paidAt ?? ''))),
        DataCell(Text(cubit.getTransactionType(transaction))),
        DataCell(Text(cubit.getDeviceInfo(transaction))),
        DataCell(Text(cubit.getShopInfo(transaction))),
        DataCell(Text(transaction.paymentMethod ?? 'N/A')),
        DataCell(Text("${transaction.amount?.toStringAsFixed(2) ?? '0.00'} $currency")),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(statusLabel, style: TextStyle(color: statusColor)),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isRTL ? MainAxisAlignment.end : MainAxisAlignment.start,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}