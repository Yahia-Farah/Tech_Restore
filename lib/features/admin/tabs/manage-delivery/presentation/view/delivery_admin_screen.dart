import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../../../core/widgets/custom_text_field.dart';
import '../../../../../../core/widgets/toast_helper.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../data/model/delivery-model/content_delivery_admin.dart';
import '../viewmodel/deliveries_cubit.dart';
import '../viewmodel/states/deliveries_states.dart';

class DeliveryAdminScreen extends StatefulWidget {
  const DeliveryAdminScreen({super.key});

  @override
  State<DeliveryAdminScreen> createState() => _DeliveryAdminScreenState();
}

class _DeliveryAdminScreenState extends State<DeliveryAdminScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = "All";
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<DeliveriesCubit>().getAllDeliveries(_currentPage);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onFilterChanged(String filter) {
    setState(() {
      _selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<DeliveriesCubit, DeliveriesState>(
        listener: (context, state) {
          if (state is DeliveriesError) {
            ToastHelper.showCustomToast(
              context,
              text: state.message,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          List<ContentDeliveryAdmin> deliveries = [];
          int totalDeliveries = 0;
          int pendingDeliveries = 0;
          int approvedDeliveries = 0;

          if (state is DeliveriesLoaded) {
            final contentList = state.deliveries.content;
            deliveries = contentList != null
                ? List<ContentDeliveryAdmin>.from(contentList)
                : <ContentDeliveryAdmin>[];
            totalDeliveries = state.deliveries.totalElements ?? 0;

            pendingDeliveries = deliveries.where((d) => d.status?.toLowerCase() == 'pending').length;
            approvedDeliveries = deliveries.where((d) => d.status?.toLowerCase() == 'approved').length;
          }

          final filteredDeliveries = _searchQuery.isEmpty
              ? deliveries
              : deliveries.where((delivery) {
                  final query = _searchQuery.toLowerCase();
                  return (delivery.name ?? '').toLowerCase().contains(query) ||
                         (delivery.email ?? '').toLowerCase().contains(query) ||
                         (delivery.phone ?? '').toLowerCase().contains(query);
                }).toList();

          final statusFilteredDeliveries = _selectedFilter == "All"
              ? filteredDeliveries
              : filteredDeliveries.where((delivery) {
                  return delivery.status?.toLowerCase() == _selectedFilter.toLowerCase();
                }).toList();

          return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.local_shipping,
                  color: AppColors.primary[70],
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  local.delivery_management,
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
              local.monitor_and_manage_delivery,
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
                    icon: Icons.local_shipping,
                    iconColor: AppColors.primary[70] ?? AppColors.black,
                    label: local.total_deliveries,
                    value: totalDeliveries.toString(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.pending_outlined,
                    iconColor: Colors.orange,
                    label: local.pending,
                    value: pendingDeliveries.toString(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    icon: Icons.check_circle_outline,
                    iconColor: Colors.green,
                    label: local.approved,
                    value: approvedDeliveries.toString(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              local.search,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.hint,
              ),
            ),
            const SizedBox(height: 8),
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
                      hint: local.search_by_name_email_phone,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.black[30]!,
                      ),
                      onChanged: (val) {
                        setState(() => _searchQuery = val);
                      },
                    ),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _buildFilterButton(
                                local.all,
                                "All",
                                Icons.list,
                                _selectedFilter == "All",
                                onPressed: () => _onFilterChanged("All"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildFilterButton(
                                local.pending,
                                "Pending",
                                Icons.close,
                                _selectedFilter == "Pending",
                                onPressed: () => _onFilterChanged("Pending"),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildFilterButton(
                                local.approved,
                                "Approved",
                                Icons.check,
                                _selectedFilter == "Approved",
                                onPressed: () => _onFilterChanged("Approved"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildFilterButton(
                                local.suspended,
                                "Suspended",
                                Icons.delete_outline,
                                _selectedFilter == "Suspended",
                                onPressed: () => _onFilterChanged("Suspended"),
                              ),
                            ),
                          ],
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
                          flex: 1,
                          child: Text(
                            local.id.toUpperCase(),
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
                            local.name.toUpperCase(),
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
                            local.email.toUpperCase(),
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
                            local.phone.toUpperCase(),
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
                            local.status.toUpperCase(),
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
                            local.completed.toUpperCase(),
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
                  if (state is DeliveriesLoading)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(60.0),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (statusFilteredDeliveries.isEmpty)
                    _buildEmptyState(local)
                  else
                    ...statusFilteredDeliveries.map((delivery) {
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
                              flex: 1,
                              child: Text(
                                delivery.id ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                delivery.name ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                delivery.email ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                delivery.phone ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: _buildStatusChip(delivery.status ?? ''),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                (delivery.totalCompletedDeliveries ?? 0).toString(),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, size: 16, color: Colors.green),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                                    onPressed: () {},
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

  Widget _buildFilterButton(
    String text,
    String value,
    IconData icon,
    bool isSelected,
    {required VoidCallback onPressed}
  ) {
    return SizedBox(
      height: 50,
      child: CustomElevatedButton(
        text: text,
        onPressed: onPressed,
        color: isSelected ? AppColors.primary[70] : AppColors.grey,
        textColor: isSelected ? AppColors.white : AppColors.black,
        width: double.infinity,
        height: 42,
        borderRadius: 8,
        suffixIcon: Icon(
          icon,
          size: 18,
          color: isSelected ? AppColors.white : AppColors.black,
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    Color textColor;
    String displayText;

    switch (status.toLowerCase()) {
      case 'pending':
        bgColor = Colors.orange.withOpacity(0.15);
        textColor = Colors.orange;
        displayText = 'Pending';
        break;
      case 'approved':
        bgColor = Colors.green.withOpacity(0.15);
        textColor = Colors.green;
        displayText = 'Approved';
        break;
      case 'suspended':
        bgColor = Colors.red.withOpacity(0.15);
        textColor = Colors.red;
        displayText = 'Suspended';
        break;
      default:
        bgColor = AppColors.grey;
        textColor = AppColors.black;
        displayText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        displayText,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
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
            Icons.local_shipping,
            size: 80,
            color: AppColors.black[30]!,
          ),
          const SizedBox(height: 16),
          Text(
            local.no_deliveries_available,
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

