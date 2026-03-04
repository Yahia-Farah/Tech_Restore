import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/config/di.dart';

import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../viewmodel/repair_requests_cubit.dart';
import '../viewmodel/states/repair_requests_states.dart';

class AdminRepairRequestsScreen extends StatefulWidget {
  const AdminRepairRequestsScreen({super.key});

  @override
  State<AdminRepairRequestsScreen> createState() => _AdminRepairRequestsScreenState();
}

class _AdminRepairRequestsScreenState extends State<AdminRepairRequestsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _statusFilter = "all";
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    if (_statusFilter == "all") {
      context.read<RepairRequestsCubit>().getAllRepairRequests(_currentPage);
    } else {
      context.read<RepairRequestsCubit>().getRepairRequestsByStatus(_statusFilter, _currentPage);
    }
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
      body: BlocBuilder<RepairRequestsCubit, RepairRequestsStates>(
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

                // Stats cards
                _buildStatsCards(l10n, state),
                const SizedBox(height: 24),

                // Search and Filter
                _buildSearchAndFilter(l10n),
                const SizedBox(height: 20),

                // Repair requests table
                _buildRepairRequestsTable(l10n, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsCards(AppLocalizations l10n, RepairRequestsStates state) {
    int totalRequests = 0;
    int pendingCount = 0;
    int completedCount = 0;

    if (state is RepairRequestsSuccess) {
      totalRequests = state.repairRequests.totalElements ?? 0;
      // Count by status from content
      final content = state.repairRequests.content ?? [];
      pendingCount = content.where((r) => r.status?.toLowerCase() == 'pending').length;
      completedCount = content.where((r) => r.status?.toLowerCase() == 'completed').length;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            title: l10n.repair_requests,
            count: totalRequests.toString(),
            icon: Icons.build,
            color: AppColors.primary,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.pending,
            count: pendingCount.toString(),
            icon: Icons.pending,
            color: Colors.orange,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.completed,
            count: completedCount.toString(),
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
                      _currentPage = 0;
                      _loadData();
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
                        _currentPage = 0;
                        _loadData();
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

  Widget _buildRepairRequestsTable(AppLocalizations l10n, RepairRequestsStates state) {
    if (state is RepairRequestsLoading) {
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
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      );
    }

    if (state is RepairRequestsError) {
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
                Icons.error_outline,
                size: 64,
                color: Colors.red[400],
              ),
              const SizedBox(height: 16),
              Text(
                state.message,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadData,
                child: Text(l10n.retry),
              ),
            ],
          ),
        ),
      );
    }

    if (state is RepairRequestsSuccess) {
      final requests = state.repairRequests.content ?? [];
      
      // Filter by search query
      final filteredRequests = requests.where((request) {
        if (_searchQuery.isEmpty) return true;
        final query = _searchQuery.toLowerCase();
        return (request.shopName?.toLowerCase().contains(query) ?? false) ||
               (request.description?.toLowerCase().contains(query) ?? false) ||
               (request.deviceCategory?.toLowerCase().contains(query) ?? false) ||
               (request.status?.toLowerCase().contains(query) ?? false);
      }).toList();

      if (filteredRequests.isEmpty) {
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

      return Column(
        children: [
          Container(
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
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(AppColors.grey.withOpacity(0.3)),
                columns: [
                  DataColumn(label: Text(l10n.shop_name)),
                  const DataColumn(label: Text('Device Category')),
                  DataColumn(label: Text(l10n.description)),
                  DataColumn(label: Text(l10n.price)),
                  DataColumn(label: Text(l10n.status)),
                  const DataColumn(label: Text('Delivery Method')),
                  const DataColumn(label: Text('Payment Method')),
                  const DataColumn(label: Text('Confirmed')),
                ],
                rows: filteredRequests.map((request) {
                  return DataRow(
                    cells: [
                      DataCell(Text(request.shopName ?? 'N/A')),
                      DataCell(Text(request.deviceCategory ?? 'N/A')),
                      DataCell(
                        SizedBox(
                          width: 200,
                          child: Text(
                            request.description ?? 'N/A',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      DataCell(Text('${request.price ?? 0} EGP')),
                      DataCell(_buildStatusChip(request.status ?? 'N/A')),
                      DataCell(Text(request.deliveryMethod ?? 'N/A')),
                      DataCell(Text(request.paymentMethod ?? 'N/A')),
                      DataCell(
                        Icon(
                          request.confirmed == true ? Icons.check_circle : Icons.cancel,
                          color: request.confirmed == true ? Colors.green : Colors.red,
                          size: 20,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Pagination
          _buildPagination(state.repairRequests.totalPages ?? 0),
        ],
      );
    }

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

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'in_progress':
        color = Colors.blue;
        break;
      case 'completed':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildPagination(int totalPages) {
    if (totalPages <= 1) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: _currentPage > 0
              ? () {
                  setState(() => _currentPage--);
                  _loadData();
                }
              : null,
          icon: const Icon(Icons.chevron_left),
        ),
        Text('${_currentPage + 1} / $totalPages'),
        IconButton(
          onPressed: _currentPage < totalPages - 1
              ? () {
                  setState(() => _currentPage++);
                  _loadData();
                }
              : null,
          icon: const Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}