import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';

class AdminTransactionsScreen extends StatefulWidget {
  const AdminTransactionsScreen({super.key});

  @override
  State<AdminTransactionsScreen> createState() =>
      _AdminTransactionsScreenState();
}

class _AdminTransactionsScreenState extends State<AdminTransactionsScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  int _totalTransactions = 0;
  double _totalRevenue = 0.0;
  List<Map<String, dynamic>> _transactions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchByUserId() {
    setState(() {
    });
  }

  void _showAllTransactions() {
    setState(() {
      _searchQuery = "";
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
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
              style: TextStyle(
                fontSize: 14,
                color: AppColors.black[40],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: AppColors.black[30]!, width: 1),
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
                            _totalTransactions.toString(),
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
                      side: BorderSide(color: AppColors.black[30]!, width: 1),
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
                            "${_totalRevenue.toStringAsFixed(2)} ${local.egp}",
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
                        setState(() => _searchQuery = val);
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
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                  if (_transactions.isEmpty)
                    _buildEmptyState(local)
                  else
                    ..._transactions.map((transaction) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                                transaction['id'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                transaction['userId'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                "${transaction['amount'] ?? '0.00'} ${local.egp}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                transaction['date'] ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                transaction['type'] ?? '',
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
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations local) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(60.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: AppColors.black[30]!,
          ),
          const SizedBox(height: 16),
          Text(
            local.no_transactions_available,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.black[40]!,
            ),
          ),
        ],
      ),
    );
  }
}
