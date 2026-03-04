import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../viewmodel/admin_offers_cubit.dart';
import '../viewmodel/states/admin_offers_states.dart';

class AdminOffersScreen extends StatefulWidget {
  const AdminOffersScreen({super.key});

  @override
  State<AdminOffersScreen> createState() => _AdminOffersScreenState();
}

class _AdminOffersScreenState extends State<AdminOffersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _statusFilter = "all";

  @override
  void initState() {
    super.initState();
    // Load initial offers data
    context.read<AdminOffersCubit>().getAdminOffers(0);
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
      body: BlocConsumer<AdminOffersCubit, AdminOffersState>(
        listener: (context, state) {
          if (state is AdminOffersError) {
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
                      Icons.local_offer,
                      color: AppColors.primary,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      l10n.offersTitle,
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
                  l10n.offersSubtitle,
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

                // Offers table
                _buildOffersTable(l10n, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatsCards(AppLocalizations l10n, AdminOffersState state) {
    int totalCount = 0;
    int activeCount = 0;
    int expiredCount = 0;

    if (state is AdminOffersLoaded) {
      totalCount = state.offers.totalElements ?? 0;
      final offers = state.offers.content ?? [];
      activeCount = offers.where((o) => o.status?.toLowerCase() == 'active').length;
      expiredCount = offers.where((o) => o.status?.toLowerCase() == 'expired').length;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            title: l10n.total_offers,
            count: totalCount.toString(),
            icon: Icons.local_offer,
            color: AppColors.primary,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.active,
            count: activeCount.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.expired,
            count: expiredCount.toString(),
            icon: Icons.cancel,
            color: Colors.red,
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
                hint: l10n.searchOffers,
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
                    hint: Text(l10n.filter_by_status), // TODO: Add to localization
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: "all",
                        child: Text(l10n.all),
                      ),
                      DropdownMenuItem(
                        value: "active",
                        child: Text(l10n.active),
                      ),
                      DropdownMenuItem(
                        value: "expired",
                        child: Text(l10n.expired), // TODO: Add to localization
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
                  hint: l10n.searchOffers,
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
                      hint: Text(l10n.filter_by_status),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem(
                          value: "all",
                          child: Text(l10n.all),
                        ),
                        DropdownMenuItem(
                          value: "active",
                          child: Text(l10n.active),
                        ),
                        DropdownMenuItem(
                          value: "expired",
                          child: Text(l10n.expired),
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

  Widget _buildOffersTable(AppLocalizations l10n, AdminOffersState state) {
    if (state is AdminOffersLoading) {
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

    if (state is AdminOffersLoaded) {
      final offers = state.offers.content ?? [];
      
      // Apply search and status filters
      final filteredOffers = offers.where((offer) {
        final matchesSearch = _searchQuery.isEmpty ||
            (offer.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false) ||
            (offer.shopName?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
        
        final matchesStatus = _statusFilter == 'all' ||
            (offer.status?.toLowerCase() == _statusFilter.toLowerCase());
        
        return matchesSearch && matchesStatus;
      }).toList();

      if (filteredOffers.isEmpty) {
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
                  Icons.local_offer_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.no_offers_available,
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

      return Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.grey[50]),
            columns: [
              DataColumn(label: Text(l10n.offer_name.toUpperCase())),
              DataColumn(label: Text(l10n.shop_name.toUpperCase())),
              DataColumn(label: Text(l10n.discount.toUpperCase())),
              DataColumn(label: Text(l10n.start_date.toUpperCase())),
              DataColumn(label: Text(l10n.end_date.toUpperCase())),
              DataColumn(label: Text(l10n.status.toUpperCase())),
              DataColumn(label: Text(l10n.actions.toUpperCase())),
            ],
            rows: filteredOffers.map((offer) {
              return DataRow(
                cells: [
                  DataCell(Text(offer.name ?? 'N/A')),
                  DataCell(Text(offer.shopName ?? 'N/A')),
                  DataCell(Text('${offer.discountValue ?? 0}${offer.discountType == 'PERCENTAGE' ? '%' : ' EGP'}')),
                  DataCell(Text(offer.startDate ?? 'N/A')),
                  DataCell(Text(offer.endDate ?? 'N/A')),
                  DataCell(_buildStatusChip(offer.status ?? 'N/A')),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
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
                            // TODO: Edit offer
                          },
                          tooltip: l10n.edit,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      );
    }

    // Default empty state
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
              Icons.local_offer_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              l10n.no_offers_available,
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
    Color backgroundColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'active':
        backgroundColor = const Color(0xFFE8F5E9);
        textColor = const Color(0xFF4CAF50);
        break;
      case 'expired':
        backgroundColor = const Color(0xFFFFEBEE);
        textColor = const Color(0xFFE53935);
        break;
      case 'pending':
        backgroundColor = const Color(0xFFFFF3E0);
        textColor = const Color(0xFFFFA726);
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