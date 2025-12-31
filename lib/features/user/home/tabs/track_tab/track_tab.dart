import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/config/di.dart';
import '../../../../user/orders/presentation/viewmodel/user_orders_cubit.dart';
import '../../../../user/orders/presentation/viewmodel/user_orders_state.dart';

class Tracktab extends StatefulWidget {
  const Tracktab({super.key});

  @override
  State<Tracktab> createState() => _TracktabState();
}

class _TracktabState extends State<Tracktab> {
  String? selectedOrderId;

  List<Map<String, dynamic>> getStatusUpdatesForOrder(String status) {
    // Handle different possible status values and map them to our timeline
    final statusMap = {
      'PENDING': 0,
      'CONFIRMED': 1,
      'PROCESSING': 2,
      'FINISHED_PROCESSING': 3,
      'SHIPPED': 4,
      'DELIVERED': 5,
      'CANCELLED': -1, // Special case for cancelled orders
    };

    final currentIndex = statusMap[status.toUpperCase()] ?? 0;

    // If order is cancelled, show all steps as incomplete except pending
    if (currentIndex == -1) {
      return [
        {
          "status": "Pending",
          "icon": Icons.access_time,
          "isCompleted": true,
          "isCurrent": false,
        },
        {
          "status": "Cancelled",
          "icon": Icons.cancel,
          "isCompleted": true,
          "isCurrent": true,
        },
      ];
    }

    return [
      {
        "status": "Pending",
        "icon": Icons.access_time,
        "isCompleted": currentIndex >= 0,
        "isCurrent": currentIndex == 0,
      },
      {
        "status": "Confirmed",
        "icon": Icons.check_circle,
        "isCompleted": currentIndex >= 1,
        "isCurrent": currentIndex == 1,
      },
      {
        "status": "Processing",
        "icon": Icons.settings,
        "isCompleted": currentIndex >= 2,
        "isCurrent": currentIndex == 2,
      },
      {
        "status": "Finished Processing",
        "icon": Icons.check_circle,
        "isCompleted": currentIndex >= 3,
        "isCurrent": currentIndex == 3,
      },
      {
        "status": "Shipped",
        "icon": Icons.local_shipping,
        "isCompleted": currentIndex >= 4,
        "isCurrent": currentIndex == 4,
      },
      {
        "status": "Delivered",
        "icon": Icons.check_circle,
        "isCompleted": currentIndex >= 5,
        "isCurrent": currentIndex == 5,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<UserOrdersCubit>()..getUserOrders(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              local.repairStatue,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: BlocBuilder<UserOrdersCubit, UserOrdersState>(
          builder: (context, state) {
            if (state is UserOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is UserOrdersError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading orders',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(color: Colors.grey[500]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<UserOrdersCubit>().getUserOrders();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final orders = context.read<UserOrdersCubit>().orders;

            if (orders.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No orders to track',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You haven\'t placed any orders yet',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              );
            }

            // Set default selected order if not set or if selected order no longer exists
            if (selectedOrderId == null || !orders.any((order) => order.id == selectedOrderId)) {
              selectedOrderId = orders.isNotEmpty ? orders.first.id : null;
            }

            if (selectedOrderId == null) {
              return const Center(
                child: Text('No order selected'),
              );
            }

            final selectedOrder = orders.firstWhere(
                  (order) => order.id == selectedOrderId,
              orElse: () => orders.first,
            );

            final statusUpdates = getStatusUpdatesForOrder(selectedOrder.status);

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Order Dropdown Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedOrderId,
                        isExpanded: true,
                        icon: const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedOrderId = newValue;
                            });
                          }
                        },
                        items: orders.map<DropdownMenuItem<String>>((order) {
                          return DropdownMenuItem<String>(
                            value: order.id,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                'Order #${order.id.substring(0, 8)}... - ${order.status}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Live Tracking Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Live Tracking: Order #${selectedOrder.id.substring(0, 8)}...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Progress Timeline
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.builder(
                        itemCount: statusUpdates.length,
                        itemBuilder: (context, index) {
                          final item = statusUpdates[index];
                          final isLast = index == statusUpdates.length - 1;

                          return IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Timeline indicator
                                Column(
                                  children: [
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: item['status'] == 'Cancelled'
                                            ? Colors.red
                                            : item['isCompleted']
                                            ? AppColors.primary
                                            : Colors.grey.shade300,
                                        shape: BoxShape.circle,
                                        boxShadow: (item['isCompleted'] || item['status'] == 'Cancelled') ? [
                                          BoxShadow(
                                            color: item['status'] == 'Cancelled'
                                                ? Colors.red.withValues(alpha: 0.3)
                                                : AppColors.primary.withValues(alpha: 0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 2),
                                          ),
                                        ] : null,
                                      ),
                                      child: Icon(
                                        item['icon'],
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                    if (!isLast)
                                      Container(
                                        width: 3,
                                        height: 30,
                                        margin: const EdgeInsets.symmetric(vertical: 8),
                                        decoration: BoxDecoration(
                                          color: item['isCompleted']
                                              ? AppColors.primary
                                              : Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(width: 20),

                                // Status content
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(top: 10, bottom: 16),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['status'],
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                            color: item['status'] == 'Cancelled'
                                                ? Colors.red
                                                : item['isCompleted']
                                                ? AppColors.primary
                                                : Colors.grey.shade600,
                                          ),
                                        ),
                                        if (item['isCurrent'] == true) ...[
                                          const SizedBox(height: 6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: item['status'] == 'Cancelled'
                                                  ? Colors.red.withValues(alpha: 0.1)
                                                  : AppColors.primary.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Text(
                                              'Current Status',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: item['status'] == 'Cancelled'
                                                    ? Colors.red
                                                    : AppColors.primary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}