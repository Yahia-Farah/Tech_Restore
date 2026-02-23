import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../viewmodel/subscription_cubit.dart';
import '../viewmodel/states/subscription_states.dart';

class AdminSubscriptionScreen extends StatefulWidget {
  const AdminSubscriptionScreen({super.key});

  @override
  State<AdminSubscriptionScreen> createState() => _AdminSubscriptionScreenState();
}

class _AdminSubscriptionScreenState extends State<AdminSubscriptionScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _filterValue = "all";
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    // Load initial subscription data
    context.read<SubscriptionCubit>().getSubscriptions(0, _filterValue);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<SubscriptionCubit, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Icon(
                      Icons.subscriptions,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.subscription_management,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.monitor_and_manage_subscriptions,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),

                // Stats cards
                _buildStatsCards(l10n, state),
                const SizedBox(height: 24),

                // Search and Filter
                _buildSearchAndFilterSection(l10n),
                const SizedBox(height: 20),

                // Subscription table
                _buildSubscriptionTable(l10n, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsCards(AppLocalizations l10n, SubscriptionState state) {
    int totalCount = 0;
    int activeCount = 0;
    int pendingPayments = 0;
    int pendingCash = 0;

    if (state is SubscriptionLoaded) {
      totalCount = state.subscriptions.totalElements ?? 0;
      // Calculate stats from the loaded data
      final subscriptions = state.subscriptions.content ?? [];
      activeCount = subscriptions.where((s) => s.isActive == true).length;
      pendingPayments = subscriptions.where((s) => s.paymentStatus?.toLowerCase() == 'pending').length;
      pendingCash = subscriptions.where((s) => s.paymentMethod?.toLowerCase() == 'cash' && s.paymentStatus?.toLowerCase() == 'pending').length;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            title: l10n.total_subscriptions,
            count: totalCount.toString(),
            icon: Icons.description_outlined,
            color: AppColors.primary,
            backgroundColor: const Color(0xFFE8F5E9),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.active,
            count: activeCount.toString(),
            icon: Icons.check_circle_outline,
            color: const Color(0xFF4CAF50),
            backgroundColor: const Color(0xFFE8F5E9),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.pending_payments,
            count: pendingPayments.toString(),
            icon: Icons.access_time,
            color: const Color(0xFFFFA726),
            backgroundColor: const Color(0xFFFFF3E0),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.pending_cash_payments,
            count: pendingCash.toString(),
            icon: Icons.attach_money,
            color: const Color(0xFFFF7043),
            backgroundColor: const Color(0xFFFFE0B2),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
    required Color backgroundColor,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            count,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(AppLocalizations l10n) {
    return CustomTextFormField(
      controller: _searchController,
      hint: l10n.search_subscriptions,
      prefixIcon: const Icon(Icons.search, color: Colors.grey),
      onChanged: (value) {
        setState(() => _searchQuery = value);
      },
    );
  }

  Widget _buildSearchAndFilterSection(AppLocalizations l10n) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Filter Dropdown - Fixed width
                Container(
                  width: 250,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _filterValue,
                      isExpanded: true,
                      hint: Text(l10n.all_subscriptions),
                      items: [
                        DropdownMenuItem(
                          value: "all",
                          child: Text(l10n.all_subscriptions),
                        ),
                        DropdownMenuItem(
                          value: "pending_cash",
                          child: Text(l10n.pending_cash_payments_only),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _filterValue = value ?? "all");
                        // Trigger API call with new filter
                        context.read<SubscriptionCubit>().getSubscriptions(0, _filterValue);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Search Field - Fixed width to prevent overflow
                SizedBox(
                  width: MediaQuery.of(context).size.width - 250 - 12 - 32, // Calculate remaining width
                  child: CustomTextFormField(
                    controller: _searchController,
                    hint: l10n.search_by_shop_id_name_email,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    onChanged: (value) {
                      setState(() => _searchQuery = value);
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Refresh Button - Centered
          Center(
            child: CustomElevatedButton(
              text: l10n.refresh,
              onPressed: _isRefreshing ? null : _handleRefresh,
              isLoading: _isRefreshing,
              color: const Color(0xFF10B981),
              width: 140,
              height: 48,
              borderRadius: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _handleRefresh() async {
    setState(() => _isRefreshing = true);
    
    // Trigger refresh with current filter
    context.read<SubscriptionCubit>().refreshSubscriptions();
    
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _isRefreshing = false);
  }

  Widget _buildSubscriptionTable(AppLocalizations l10n, SubscriptionState state) {
    if (state is SubscriptionLoading) {
      return Container(
        padding: const EdgeInsets.all(60),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        ),
      );
    }

    if (state is SubscriptionLoaded) {
      final subscriptions = state.subscriptions.content ?? [];
      
      // Apply search filter
      final filteredSubscriptions = subscriptions.where((subscription) {
        if (_searchQuery.isEmpty) return true;
        final query = _searchQuery.toLowerCase();
        return (subscription.shopId?.toLowerCase().contains(query) ?? false) ||
               (subscription.shopName?.toLowerCase().contains(query) ?? false);
      }).toList();

      if (filteredSubscriptions.isEmpty) {
        return Container(
          padding: const EdgeInsets.all(60),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.no_subscriptions_found,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 120,
                    child: Text(
                      l10n.shop_id.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Text(
                      l10n.shop_name.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      l10n.method.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      l10n.status.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(
                      l10n.actions.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                        fontSize: 12,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Table Body
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredSubscriptions.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: Colors.grey[200],
              ),
              itemBuilder: (context, index) {
                final subscription = filteredSubscriptions[index];
                return _buildSubscriptionRow(subscription, l10n);
              },
            ),
          ],
        ),
      );
    }

    // Default empty state
    return Container(
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.description_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.no_subscriptions_found,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionRow(dynamic subscription, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              subscription.shopId ?? 'N/A',
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              subscription.shopName ?? 'N/A',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              subscription.paymentMethod ?? 'N/A',
              style: const TextStyle(fontSize: 14),
            ),
          ),
          SizedBox(
            width: 150,
            child: _buildStatusChip(subscription.paymentStatus ?? 'N/A'),
          ),
          SizedBox(
            width: 150,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 20),
                  color: AppColors.primary,
                  onPressed: () {
                    // TODO: View details
                  },
                  tooltip: l10n.view_details,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 20),
                  color: Colors.blue,
                  onPressed: () {
                    // TODO: Edit subscription
                  },
                  tooltip: l10n.edit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'paid':
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
        break;
      case 'pending':
        backgroundColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFFFA726);
        break;
      case 'failed':
      case 'cancelled':
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFE53935);
        break;
      default:
        backgroundColor = Colors.grey[200]!;
        textColor = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}