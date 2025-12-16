import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/data/models/shop_model.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/get_shops_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/states/get_shops_states.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/toast_helper.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';

class AdminRepairScreen extends StatefulWidget {
  const AdminRepairScreen({super.key});

  @override
  State<AdminRepairScreen> createState() => _AdminRepairScreenState();
}

class _AdminRepairScreenState extends State<AdminRepairScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedFilter = "All Shops";

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

  void _copyToClipboard(String text, BuildContext context, AppLocalizations local) {
    Clipboard.setData(ClipboardData(text: text));
    ToastHelper.showCustomToast(
      context,
      text: local.id_copied_to_clipboard,
      isError: false,
    );
  }

  String _getStatus(ShopModel shop) {
    if (shop.activate == false) {
      return "Suspended";
    } else if (shop.verified == true) {
      return "Approved";
    } else {
      return "Pending";
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<GetShopsCubit, GetShopsState>(
        listener: (context, state) {
          if (state is ShopApproved) {
            ToastHelper.showCustomToast(
              context,
              text: local.shop_approved_successfully,
              isError: false,
            );
          } else if (state is ShopSuspended) {
            ToastHelper.showCustomToast(
              context,
              text: local.shop_suspended_successfully,
              isError: false,
            );
          } else if (state is GetShopsError) {
            final errorMessage = state.message.toLowerCase();
            ToastHelper.showCustomToast(
              context,
              text: errorMessage.contains('approve') 
                  ? local.shop_approval_failed 
                  : errorMessage.contains('suspend')
                      ? local.shop_suspension_failed
                      : state.message,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          List<ShopModel> shops = [];
          int totalShops = 0;
          int approvedShops = 0;
          int suspendedShops = 0;

          if (state is GetShopsLoaded) {
            shops = state.shops.content ?? [];
            totalShops = shops.length;
            approvedShops = shops.where((s) => _getStatus(s) == "Approved").length;
            suspendedShops = shops.where((s) => _getStatus(s) == "Suspended").length;
          }

          final filteredShops = _searchQuery.isEmpty
              ? shops
              : shops.where((shop) {
                  final query = _searchQuery.toLowerCase();
                  return (shop.name ?? '').toLowerCase().contains(query) ||
                         (shop.email ?? '').toLowerCase().contains(query);
                }).toList();

          final statusFilteredShops = _selectedFilter == "All Shops"
              ? filteredShops
              : filteredShops.where((shop) {
                  final status = _getStatus(shop);
                  if (_selectedFilter == "Approved Shops") {
                    return status == "Approved";
                  } else if (_selectedFilter == "Suspended Shops") {
                    return status == "Suspended";
                  }
                  return true;
                }).toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.store,
                      color: AppColors.primary[70],
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      local.shops_management,
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
                  local.manage_approve_suspend_view_shop_details,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.black[40],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.store,
                        iconColor: AppColors.primary[70] ?? AppColors.black,
                        label: local.total_shops,
                        value: totalShops.toString(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.check_circle_outline,
                        iconColor: Colors.green,
                        label: local.approved,
                        value: approvedShops.toString(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildMetricCard(
                        icon: Icons.block,
                        iconColor: Colors.red,
                        label: local.suspended,
                        value: suspendedShops.toString(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            local.search,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.hint,
                            ),
                          ),
                          const SizedBox(height: 8),
                          CustomTextFormField(
                            controller: _searchController,
                            hint: local.search_by_name_or_email,
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.black[30]!,
                            ),
                            onChanged: (val) {
                              setState(() => _searchQuery = val);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            local.filter_by_status,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.hint,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 52,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.black[30]!,
                                width: 1,
                              ),
                            ),
                            child: DropdownButton<String>(
                              value: _selectedFilter,
                              isExpanded: true,
                              underline: const SizedBox(),
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14,
                              ),
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.black[50],
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: "All Shops",
                                  child: Text(local.all_shops),
                                ),
                                DropdownMenuItem(
                                  value: "Approved Shops",
                                  child: Text(local.approved_shops),
                                ),
                                DropdownMenuItem(
                                  value: "Suspended Shops",
                                  child: Text(local.suspended_shops),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _selectedFilter = value ?? "All Shops";
                                });
                              },
                            ),
                          ),
                        ],
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width - 32,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                color: AppColors.grey,
                                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        local.id.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: AppColors.black[50],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        local.name.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: AppColors.black[50],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        local.status.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: AppColors.black[50],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        local.shop_type.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: AppColors.black[50],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        local.actions.toUpperCase(),
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
                              if (state is GetShopsLoading)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(60.0),
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              else if (statusFilteredShops.isEmpty)
                                _buildEmptyState(local)
                              else
                                ...statusFilteredShops.map((shop) {
                                  return Container(
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
                                        SizedBox(
                                          width: 200,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  shop.id ?? '',
                                                  style: const TextStyle(fontSize: 12),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              InkWell(
                                                onTap: () => _copyToClipboard(shop.id ?? '', context, local),
                                                child: const Icon(
                                                  Icons.copy,
                                                  size: 16,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            shop.name ?? '',
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: _buildStatusChip(_getStatus(shop)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: Text(
                                            shop.shopType?.toUpperCase() ?? '',
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 250,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              _buildActionButton(
                                                text: local.view,
                                                onPressed: () => _showShopDetailsDialog(context, shop, local),
                                              ),
                                              const SizedBox(width: 8),
                                              _getStatus(shop) == "Approved"
                                                  ? _buildSuspendButton(
                                                      onPressed: () {
                                                        if (shop.id != null) {
                                                          context.read<GetShopsCubit>().suspendShop(shop.id!);
                                                        }
                                                      },
                                                    )
                                                  : _buildActionButton(
                                                      text: local.approve,
                                                      onPressed: () {
                                                        if (shop.id != null) {
                                                          context.read<GetShopsCubit>().approveShop(shop.id!);
                                                        }
                                                      },
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return SizedBox(
      height: 140,
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.black[40],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;

    switch (status.toLowerCase()) {
      case 'approved':
        bgColor = Colors.green;
        textColor = Colors.white;
        break;
      case 'suspended':
        bgColor = Colors.red;
        textColor = Colors.white;
        break;
      case 'pending':
        bgColor = Colors.orange;
        textColor = Colors.white;
        break;
      default:
        bgColor = AppColors.grey;
        textColor = AppColors.black;
    }

    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          status,
          style: TextStyle(
            color: textColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary[70]?.withOpacity(0.15) ?? Colors.green.shade100,
        foregroundColor: AppColors.primary[70] ?? Colors.green.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.primary[70] ?? Colors.green.shade700,
        ),
      ),
    );
  }

  Widget _buildSuspendButton({
    required VoidCallback onPressed,
  }) {
    final local = AppLocalizations.of(context)!;
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange.withOpacity(0.15),
        foregroundColor: Colors.orange.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: Text(
        local.suspend,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.orange.shade700,
        ),
      ),
    );
  }

  void _showShopDetailsDialog(BuildContext context, ShopModel shop, AppLocalizations local) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.9,
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          local.shop_details,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary[70],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          color: AppColors.black[50],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          local.shop_information,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final shopInfo = 'ID: ${shop.id}\nName: ${shop.name}\nEmail: ${shop.email}\nPhone: ${shop.phone}\nStatus: ${_getStatus(shop)}\nRating: ${shop.rating ?? "N/A"}\nShop Type: ${shop.shopType ?? "N/A"}\nDescription: ${shop.description ?? "N/A"}';
                            Clipboard.setData(ClipboardData(text: shopInfo));
                            ToastHelper.showCustomToast(
                              dialogContext,
                              text: local.data_copied_to_clipboard,
                              isError: false,
                            );
                          },
                          child: const Icon(
                            Icons.copy,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailRow(local.id, shop.id ?? 'N/A'),
                                    const SizedBox(height: 12),
                                    _buildDetailRow(local.name, shop.name ?? 'N/A'),
                                    const SizedBox(height: 12),
                                    _buildDetailRow(local.email, shop.email ?? 'N/A'),
                                    const SizedBox(height: 12),
                                    _buildDetailRow(local.phone, shop.phone ?? 'N/A'),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildDetailRow(local.status, _getStatus(shop), isStatus: true),
                                    const SizedBox(height: 12),
                                    _buildDetailRow(local.rating, shop.rating != null ? shop.rating!.toStringAsFixed(1) : 'N/A'),
                                    const SizedBox(height: 12),
                                    _buildDetailRow(local.shop_type, shop.shopType?.toUpperCase() ?? 'N/A'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _buildDetailRow(local.description, shop.description ?? 'N/A', isFullWidth: true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Center(
                      child: CustomElevatedButton(
                        text: local.close,
                        onPressed: () => Navigator.of(dialogContext).pop(),
                        color: AppColors.primary[70],
                        textColor: AppColors.white,
                        width: 98,
                        height: 50,
                        borderRadius: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false, bool isFullWidth = false}) {
    Widget valueWidget = Text(
      value,
      style: TextStyle(
        fontSize: 12,
        color: isStatus && value == "Suspended" ? Colors.red : AppColors.black,
        fontWeight: isStatus ? FontWeight.bold : FontWeight.normal,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    return isFullWidth
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label:',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 4),
              valueWidget,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$label:',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: valueWidget,
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
          Icon(
            Icons.store,
            size: 80,
            color: AppColors.black[30]!,
          ),
          const SizedBox(height: 16),
          Text(
            local.no_shops_match_filters,
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
