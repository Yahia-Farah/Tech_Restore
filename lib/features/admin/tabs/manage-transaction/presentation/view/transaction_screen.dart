import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/toast_helper.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../data/model/transaction-models/transaction_content.dart';
import '../viewmodel/transactions_cubit.dart';
import '../viewmodel/states/transactions_states.dart';

class AdminTransactionsScreen extends StatefulWidget {
  const AdminTransactionsScreen({super.key});

  @override
  State<AdminTransactionsScreen> createState() =>
      _AdminTransactionsScreenState();
}

class _AdminTransactionsScreenState extends State<AdminTransactionsScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    log(
      '📱 [AdminTransactionsScreen] initState called, triggering getAllTransactions API call',
    );
    context.read<TransactionsCubit>().getAllTransactions(_currentPage);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchByUserId() {
    final userId = _searchController.text.trim();
    setState(() {
      _searchQuery = userId;
      _currentPage = 0;
    });
    context.read<TransactionsCubit>().getAllTransactions(_currentPage);
  }

  void _showAllTransactions() {
    setState(() {
      _searchQuery = "";
      _searchController.clear();
      _currentPage = 0;
    });
    context.read<TransactionsCubit>().getAllTransactions(_currentPage);
  }

  void _loadPage(int page) {
    setState(() {
      _currentPage = page;
    });
    context.read<TransactionsCubit>().getAllTransactions(page);
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<TransactionsCubit, TransactionsState>(
        listener: (context, state) {
          if (state is TransactionsError) {
            ToastHelper.showCustomToast(
              context,
              text: state.message,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          List<TransactionContent> transactions = [];
          int totalTransactions = 0;
          double totalRevenue = 0.0;

          if (state is TransactionsLoaded) {
            final contentList = state.transactions.content;
            transactions =
                contentList != null
                    ? List<TransactionContent>.from(contentList)
                    : <TransactionContent>[];
            totalTransactions = state.transactions.totalElements ?? 0;

            totalRevenue = transactions.fold(0.0, (sum, transaction) {
              return sum + (transaction.amount ?? 0).toDouble();
            });
          }

          final filteredTransactions =
              _searchQuery.isEmpty
                  ? transactions
                  : transactions.where((transaction) {
                    final query = _searchQuery.toLowerCase();
                    return (transaction.userId ?? '').toLowerCase().contains(
                          query,
                        ) ||
                        (transaction.transactionId ?? '')
                            .toLowerCase()
                            .contains(query);
                  }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.receipt_long,
                      color: AppColors.primary[70],
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      local.transactions_management,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary[70],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  local.view_and_monitor_transactions,
                  style: TextStyle(fontSize: 14, color: AppColors.black[40]),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: AppColors.black[30]!,
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.receipt_long,
                                color: AppColors.primary[70],
                                size: 24,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                local.total_transactions,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black[40],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                totalTransactions.toString(),
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Card(
                        color: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: AppColors.black[30]!,
                            width: 1,
                          ),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.attach_money,
                                color: AppColors.primary[70],
                                size: 24,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                local.total_revenue,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black[40],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "${totalRevenue.toStringAsFixed(2)} ${local.egp}",
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.black[30]!, width: 1),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: _searchController,
                          hint: local.search_by_user_id,
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.black[30]!,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: CustomElevatedButton(
                                text: local.search_user,
                                onPressed: _searchByUserId,
                                color: AppColors.primary[70],
                                textColor: AppColors.white,
                                width: null,
                                height: 52,
                                borderRadius: 8,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: CustomElevatedButton(
                                text: local.show_all,
                                onPressed: _showAllTransactions,
                                color: AppColors.grey,
                                textColor: AppColors.black,
                                width: null,
                                height: 52,
                                borderRadius: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  color: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: AppColors.black[30]!, width: 1),
                  ),
                  elevation: 0,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: AppColors.grey,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                local.transaction_id,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.black[50],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                local.user_id,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.black[50],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                local.amount,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.black[50],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                local.date,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.black[50],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                local.type,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: AppColors.black[50],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (state is TransactionsLoading)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(60.0),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (filteredTransactions.isEmpty)
                        _buildEmptyState(local)
                      else
                        ...filteredTransactions.map((transaction) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.black[30]!,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    transaction.transactionId ??
                                        transaction.id ??
                                        '',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    transaction.userId ?? '',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${(transaction.amount ?? 0).toStringAsFixed(2)} ${local.egp}",
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    transaction.createdAt ??
                                        transaction.paidAt ??
                                        '',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    transaction.paymentType ??
                                        transaction.paymentMethod ??
                                        '',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
                // Pagination
                if (state is TransactionsLoaded && (state.transactions.totalPages ?? 0) > 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: _buildPagination(
                      state.transactions.totalPages ?? 0,
                      local,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPagination(int totalPages, AppLocalizations local) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _currentPage > 0
              ? () => _loadPage(_currentPage - 1)
              : null,
          icon: const Icon(Icons.chevron_left),
          color: AppColors.primary[70],
        ),
        Text(
          '${_currentPage + 1} / $totalPages',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          onPressed: _currentPage < totalPages - 1
              ? () => _loadPage(_currentPage + 1)
              : null,
          icon: const Icon(Icons.chevron_right),
          color: AppColors.primary[70],
        ),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations local) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long, size: 80, color: AppColors.black[30]!),
          const SizedBox(height: 16),
          Text(
            local.no_transactions_available,
            style: TextStyle(fontSize: 16, color: AppColors.black[40]!),
          ),
        ],
      ),
    );
  }
}
