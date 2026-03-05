import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/data/models/shop_model.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/get_shops_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/states/get_shops_states.dart';

import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_toast.dart';
import '../../../../../auth/data/models/signup_shop_models/sign_up_shop_request_model.dart';

class AdminRepairScreen extends StatefulWidget {
  const AdminRepairScreen({super.key});

  @override
  State<AdminRepairScreen> createState() => _AdminRepairScreenState();
}

class _AdminRepairScreenState extends State<AdminRepairScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _statusFilter = "all";
  Set<String> _loadingShops = {}; // Track loading state per shop

  @override
  void initState() {
    super.initState();
    context.read<GetShopsCubit>().getAllShops();
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
      body: BlocConsumer<GetShopsCubit, GetShopsState>(
        listener: (context, state) {
          if (state is GetShopsError) {
            _loadingShops.clear(); // Clear loading state on error
            _showErrorToast(state.message);
          }
          if (state is ShopApproved) {
            _loadingShops.clear(); // Clear loading state on success
            _showSuccessToast(l10n.shop_approved_successfully);
          }
          if (state is ShopSuspended) {
            _loadingShops.clear(); // Clear loading state on success
            _showSuccessToast(l10n.shop_suspended_successfully);
          }
        },
        builder: (context, state) {
          if (state is GetShopsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (state is GetShopsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline, 
                    size: 64, 
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${l10n.error}: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    text: l10n.retry,
                    onPressed: () {
                      context.read<GetShopsCubit>().getAllShops();
                    },
                    width: 120,
                    height: 40,
                  ),
                ],
              ),
            );
          }

          if (state is GetShopsLoaded) {
            final shops = state.shops.content ?? [];
            final filteredShops = _getFilteredShops(shops);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.store,
                        color: AppColors.primary,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.shops_management,
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
                    l10n.manage_approve_suspend_view_shop_details,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Stats Cards
                  _buildStatsCards(shops, l10n),
                  const SizedBox(height: 24),

                  // Search and Filter
                  _buildSearchAndFilter(l10n),
                  const SizedBox(height: 20),

                  // Shops Table
                  _buildShopsTable(filteredShops, l10n, state),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  // Helper methods
  List<ShopModel> _getFilteredShops(List<ShopModel> shops) {
    return shops.where((shop) {
      // Search filter
      final query = _searchQuery.toLowerCase();
      final name = (shop.name ?? '').toLowerCase();
      final email = (shop.email ?? '').toLowerCase();
      final location = _getLocationString(shop.shopAddress).toLowerCase();
      
      final matchesSearch = name.contains(query) ||
          email.contains(query) ||
          location.contains(query);

      // Status filter
      final status = _getStatus(shop);
      final matchesStatus = _statusFilter == "all" ||
          (_statusFilter == "approved" && status == "Approved") ||
          (_statusFilter == "suspended" && status == "Suspended") ||
          (_statusFilter == "pending" && status == "Pending");

      return matchesSearch && matchesStatus;
    }).toList();
  }

  Widget _buildStatsCards(List<ShopModel> shops, AppLocalizations l10n) {
    final totalShops = shops.length;
    final approvedShops = shops.where((s) => _getStatus(s) == "Approved").length;
    final suspendedShops = shops.where((s) => _getStatus(s) == "Suspended").length;
    final pendingShops = shops.where((s) => _getStatus(s) == "Pending").length;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatCard(
            title: l10n.total_shops,
            count: totalShops.toString(),
            icon: Icons.store,
            color: AppColors.primary,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.approved,
            count: approvedShops.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.suspended,
            count: suspendedShops.toString(),
            icon: Icons.block,
            color: Colors.red,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: l10n.pending,
            count: pendingShops.toString(),
            icon: Icons.hourglass_empty,
            color: Colors.orange,
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
      width: 160, // Fixed width for horizontal scrolling
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
                hint: l10n.search_by_name_or_email,
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
                    hint: Text(l10n.filter_by_status),
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(
                        value: "all",
                        child: Text(l10n.all_shops),
                      ),
                      DropdownMenuItem(
                        value: "approved",
                        child: Text(l10n.approved_shops),
                      ),
                      DropdownMenuItem(
                        value: "suspended",
                        child: Text(l10n.suspended_shops),
                      ),
                      DropdownMenuItem(
                        value: "pending",
                        child: Text(l10n.pending),
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
                  hint: l10n.search_by_name_or_email,
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
                          child: Text(l10n.all_shops),
                        ),
                        DropdownMenuItem(
                          value: "approved",
                          child: Text(l10n.approved_shops),
                        ),
                        DropdownMenuItem(
                          value: "suspended",
                          child: Text(l10n.suspended_shops),
                        ),
                        DropdownMenuItem(
                          value: "pending",
                          child: Text(l10n.pending),
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

  Widget _buildShopsTable(List<ShopModel> shops, AppLocalizations l10n, GetShopsState state) {
    if (shops.isEmpty) {
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
                Icons.store_outlined,
                size: 64,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                l10n.no_shops_match_filters,
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Single horizontal scroll for entire table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Table Header
                Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 180,
                        child: Text(
                          l10n.id.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: Text(
                          l10n.name.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Text(
                        l10n.status.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                          fontSize: 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 140,
                        child: Text(
                          l10n.shop_type.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 380,
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
                // Table Body - All rows in one scrollable container
                Column(
                  children: shops.map((shop) => _buildShopRow(shop, l10n, state)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle _headerStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      color: AppColors.primary,
      fontSize: 14,
    );
  }

  Widget _buildShopRow(ShopModel shop, AppLocalizations l10n, GetShopsState state) {
    final status = _getStatus(shop);
    final shopId = shop.id ?? '';
    final isShopLoading = _loadingShops.contains(shopId);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          // ID
          SizedBox(
            width: 180,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    shop.id?.substring(0, 8) ?? 'N/A',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    _copyShopData(shop, l10n);
                  },
                  child: Icon(Icons.copy, size: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          // Name
          SizedBox(
            width: 180,
            child: Text(
              shop.name ?? 'N/A',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Status
          _buildStatusChip(status),
          const SizedBox(width: 20),
          // Shop Type
          SizedBox(
            width: 140,
            child: Text(
              shop.shopType ?? l10n.not_specified,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Actions
          SizedBox(
            width: 380,
            child: Row(
              children: [
                // View Button - Always visible
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: ElevatedButton.icon(
                    onPressed: () => _showShopDetails(shop, l10n),
                    icon: const Icon(Icons.visibility, size: 16),
                    label: Text(l10n.view),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                // Conditional buttons based on status
                if (status == "Pending" || status == "Suspended") ...[
                  // Approve Button for Pending and Suspended shops
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ElevatedButton.icon(
                      onPressed: isShopLoading ? null : () => _approveShop(shopId),
                      icon: isShopLoading 
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Icon(Icons.check, size: 16),
                      label: Text(l10n.approve),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ],
                if (status == "Approved") ...[
                  // Suspend Button for Approved shops only
                  ElevatedButton.icon(
                    onPressed: isShopLoading ? null : () => _suspendShop(shopId),
                    icon: isShopLoading 
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Icon(Icons.block, size: 16),
                    label: Text(l10n.suspend),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showShopDetails(ShopModel shop, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(
            maxWidth: 600,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      l10n.shop_details,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close, color: Colors.grey),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
              // Content
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shop Information Header with Copy Button
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.store,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Shop Information',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () => _copyShopData(shop, l10n),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.copy,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        
                        // Shop Details Grid
                        _buildShopDetailsGrid(shop, l10n),
                        
                        const SizedBox(height: 20),
                        
                        // Description Section
                        _buildDescriptionSection(shop, l10n),
                        
                        const SizedBox(height: 20),
                        
                        // Timestamps
                        _buildTimestamps(shop, l10n),
                      ],
                    ),
                  ),
                ),
              ),
              // Footer
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShopDetailsGrid(ShopModel shop, AppLocalizations l10n) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Mobile layout (single column)
        if (constraints.maxWidth < 500) {
          return Column(
            children: [
              _buildDetailItem(
                icon: Icons.tag,
                label: 'Shop ID',
                value: shop.id ?? 'N/A',
                isId: true,
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                icon: Icons.person,
                label: l10n.name,
                value: shop.name ?? 'N/A',
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                icon: Icons.email,
                label: l10n.email,
                value: shop.email ?? 'N/A',
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                icon: Icons.phone,
                label: l10n.phone,
                value: shop.phone ?? 'N/A',
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                icon: Icons.verified,
                label: 'Verification',
                value: _getStatus(shop),
                isStatus: true,
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                icon: Icons.visibility,
                label: 'Status',
                value: shop.activate == false ? 'Inactive' : 'Active',
                isStatus: true,
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                icon: Icons.star,
                label: l10n.rating,
                value: shop.rating?.toString() ?? 'No ratings yet',
                isRating: true,
              ),
              const SizedBox(height: 16),
              _buildDetailItem(
                icon: Icons.category,
                label: l10n.shop_type,
                value: shop.shopType ?? 'REPAIRER',
              ),
            ],
          );
        }
        
        // Desktop layout (two columns)
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.tag,
                    label: 'Shop ID',
                    value: shop.id ?? 'N/A',
                    isId: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.person,
                    label: l10n.name,
                    value: shop.name ?? 'N/A',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.email,
                    label: l10n.email,
                    value: shop.email ?? 'N/A',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.phone,
                    label: l10n.phone,
                    value: shop.phone ?? 'N/A',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.verified,
                    label: 'Verification',
                    value: _getStatus(shop),
                    isStatus: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.visibility,
                    label: 'Status',
                    value: shop.activate == false ? 'Inactive' : 'Active',
                    isStatus: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.star,
                    label: l10n.rating,
                    value: shop.rating?.toString() ?? 'No ratings yet',
                    isRating: true,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDetailItem(
                    icon: Icons.category,
                    label: l10n.shop_type,
                    value: shop.shopType ?? 'REPAIRER',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    bool isId = false,
    bool isStatus = false,
    bool isRating = false,
  }) {
    Color iconColor = Colors.grey[600]!;
    if (isStatus) {
      if (value == 'Approved') iconColor = Colors.green;
      else if (value == 'Suspended') iconColor = Colors.red;
      else if (value == 'Pending') iconColor = Colors.orange;
    } else if (isRating) {
      iconColor = Colors.orange;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Text(
            isId && value.length > 20 ? '${value.substring(0, 20)}...' : value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontFamily: isId ? 'monospace' : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(ShopModel shop, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.description, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 8),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Text(
            shop.description ?? 'No description provided',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimestamps(ShopModel shop, AppLocalizations l10n) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return Column(
            children: [
              _buildTimestampItem('Created', shop.createdAt ?? 'N/A'),
              const SizedBox(height: 12),
              _buildTimestampItem('Updated', shop.updatedAt ?? 'N/A'),
            ],
          );
        }
        
        return Row(
          children: [
            Expanded(child: _buildTimestampItem('Created', shop.createdAt ?? 'N/A')),
            const SizedBox(width: 16),
            Expanded(child: _buildTimestampItem('Updated', shop.updatedAt ?? 'N/A')),
          ],
        );
      },
    );
  }

  Widget _buildTimestampItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 12,
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  void _copyShopData(ShopModel shop, AppLocalizations l10n) {
    final shopData = '''
Shop Information:
================
Shop ID: ${shop.id ?? 'N/A'}
Name: ${shop.name ?? 'N/A'}
Email: ${shop.email ?? 'N/A'}
Phone: ${shop.phone ?? 'N/A'}
Shop Type: ${shop.shopType ?? 'N/A'}
Status: ${_getStatus(shop)}
Active: ${shop.activate == false ? 'No' : 'Yes'}
Rating: ${shop.rating?.toString() ?? 'No ratings yet'}
Description: ${shop.description ?? 'No description provided'}
Created: ${shop.createdAt ?? 'N/A'}
Updated: ${shop.updatedAt ?? 'N/A'}
''';

    Clipboard.setData(ClipboardData(text: shopData));
    _showSuccessToast('Shop data copied to clipboard');
  }

  void _showSuccessToast(String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => CustomToast(
        text: message,
        isError: false,
      ),
    );

    overlay.insert(entry);

    // Auto remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }

  void _showErrorToast(String message) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => CustomToast(
        text: message,
        isError: true,
      ),
    );

    overlay.insert(entry);

    // Auto remove after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      entry.remove();
    });
  }

  void _approveShop(String shopId) {
    if (shopId.isEmpty) return;
    
    setState(() {
      _loadingShops.add(shopId);
    });
    
    context.read<GetShopsCubit>().approveShop(shopId);
  }

  void _suspendShop(String shopId) {
    if (shopId.isEmpty) return;
    
    setState(() {
      _loadingShops.add(shopId);
    });
    
    context.read<GetShopsCubit>().suspendShop(shopId);
  }

  String _getLocationString(ShopAddress? address) {
    if (address == null) return 'N/A';
    final parts = <String>[];
    if (address.city?.isNotEmpty == true) {
      parts.add(address.city!);
    }
    if (address.state?.isNotEmpty == true) {
      parts.add(address.state!);
    }
    return parts.isEmpty ? 'N/A' : parts.join(', ');
  }

  String _getStatus(ShopModel shop) {
    // Suspended takes priority - if activate is false, shop is suspended
    if (shop.activate == false) {
      return "Suspended";
    }
    // If active and verified, it's approved
    if (shop.verified == true) {
      return "Approved";
    }
    // If active but not verified, it's pending approval
    return "Pending";
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;
    switch (status) {
      case "Approved":
        bg = Colors.green[100]!;
        text = Colors.green[700]!;
        break;
      case "Suspended":
        bg = Colors.red[100]!;
        text = Colors.red[700]!;
        break;
      case "Pending":
        bg = Colors.orange[100]!;
        text = Colors.orange[700]!;
        break;
      default:
        bg = Colors.grey[100]!;
        text = Colors.grey[700]!;
    }
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: text,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
