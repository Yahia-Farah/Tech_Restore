import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';

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
    // TODO: Initialize subscription data loading
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
      body: SingleChildScrollView(
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

            // TODO: Add stats cards
            _buildStatsCards(l10n),
            const SizedBox(height: 24),

            // Search and Filter
            _buildSearchAndFilterSection(l10n),
            const SizedBox(height: 20),

            // TODO: Add subscription table
            _buildSubscriptionTable(l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsCards(AppLocalizations l10n) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            title: l10n.total_subscriptions,
            count: '0',
            icon: Icons.description_outlined,
            color: AppColors.primary,
            backgroundColor: const Color(0xFFE8F5E9),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.active,
            count: '0',
            icon: Icons.check_circle_outline,
            color: const Color(0xFF4CAF50),
            backgroundColor: const Color(0xFFE8F5E9),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.pending_payments,
            count: '0',
            icon: Icons.access_time,
            color: const Color(0xFFFFA726),
            backgroundColor: const Color(0xFFFFF3E0),
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.pending_cash_payments,
            count: '0',
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
    
    // TODO: Add actual refresh logic here
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() => _isRefreshing = false);
  }

  Widget _buildSubscriptionTable(AppLocalizations l10n) {
    // TODO: Replace with actual data
    final hasSubscriptions = false;

    if (!hasSubscriptions) {
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
          // Table Body - TODO: Add actual data rows
          Container(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Text(
                l10n.no_subscriptions_found,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}