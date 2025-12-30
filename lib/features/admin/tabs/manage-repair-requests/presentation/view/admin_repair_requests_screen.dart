import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';

class AdminRepairRequestsScreen extends StatefulWidget {
  const AdminRepairRequestsScreen({super.key});

  @override
  State<AdminRepairRequestsScreen> createState() => _AdminRepairRequestsScreenState();
}

class _AdminRepairRequestsScreenState extends State<AdminRepairRequestsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _statusFilter = "all";

  @override
  void initState() {
    super.initState();
    // TODO: Initialize repair requests data loading
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
                  Icons.build,
                  color: AppColors.primary,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.repair_requests_title,
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
              l10n.repair_requests_subtitle,
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
            _buildSearchAndFilter(l10n),
            const SizedBox(height: 20),

            // TODO: Add repair requests table
            _buildRepairRequestsTable(l10n),
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
            title: l10n.repair_requests,
            count: '0',
            icon: Icons.build,
            color: AppColors.primary,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.pending,
            count: '0',
            icon: Icons.pending,
            color: Colors.orange,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.completed,
            count: '0',
            icon: Icons.check_circle,
            color: Colors.green,
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
  }) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
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
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            count,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(AppLocalizations l10n) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile: Stack vertically
          return Column(
            children: [
              // Search field - full width
              CustomTextFormField(
                controller: _searchController,
                hint: l10n.search_repair_requests,
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
              const SizedBox(height: 12),
              // Filter dropdown - full width
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _statusFilter,
                    hint: Text(l10n.status_filter),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: "all",
                        child: Text(l10n.all),
                      ),
                      DropdownMenuItem(
                        value: "pending",
                        child: Text(l10n.pending),
                      ),
                      DropdownMenuItem(
                        value: "in_progress",
                        child: Text(l10n.status_in_progress),
                      ),
                      DropdownMenuItem(
                        value: "completed",
                        child: Text(l10n.completed),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() => _statusFilter = value ?? "all");
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          // Desktop: Side by side
          return Row(
            children: [
              // Search field
              Expanded(
                flex: 2,
                child: CustomTextFormField(
                  controller: _searchController,
                  hint: l10n.search_repair_requests,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                ),
              ),
              const SizedBox(width: 16),
              // Filter dropdown
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _statusFilter,
                      hint: Text(l10n.status_filter),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: "all",
                          child: Text(l10n.all),
                        ),
                        DropdownMenuItem(
                          value: "pending",
                          child: Text(l10n.pending),
                        ),
                        DropdownMenuItem(
                          value: "in_progress",
                          child: Text(l10n.status_in_progress),
                        ),
                        DropdownMenuItem(
                          value: "completed",
                          child: Text(l10n.completed),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() => _statusFilter = value ?? "all");
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Widget _buildRepairRequestsTable(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(40),
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
              Icons.build_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.no_repair_requests_available,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}