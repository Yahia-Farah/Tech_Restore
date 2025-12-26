import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../data/models/orders/get_all_orders_model.dart';
import '../../viewmodel/orders_cubit.dart';
import '../../viewmodel/orders_state.dart';

class OrderDetailsDialog extends StatelessWidget {
  final String orderId;

  const OrderDetailsDialog({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxHeight: 600),
        child: BlocBuilder<OrdersCubit, OrdersState>(
          builder: (context, state) {
            if (state is OrderDetailsLoading) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
              );
            } else if (state is OrderDetailsError) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error: ${state.msg}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<OrdersCubit>().getOrderDetails(orderId);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is OrderDetailsLoaded) {
              return _buildOrderDetails(context, state.order, local, isArabic);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context, OrderContent order, AppLocalizations local, bool isArabic) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  local.order_details,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Customer Information
            _buildSection(
              title: local.customer_info,
              icon: Icons.person_outline,
              child: Column(
                children: [
                  _buildInfoRow(
                    local.name,
                    '${order.firstName ?? ''} ${order.lastName ?? ''}',
                    Icons.person,
                    isArabic,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    local.phone,
                    order.phoneNumber ?? 'N/A',
                    Icons.phone,
                    isArabic,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Payment Summary
            _buildSection(
              title: local.payment_details,
              icon: Icons.payment,
              child: Column(
                children: [
                  _buildInfoRow(
                    local.total,
                    '${order.totalPrice?.toStringAsFixed(2) ?? '0.00'} ${_getCurrency(local, context)}',
                    Icons.attach_money,
                    isArabic,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    local.paymentMethod,
                    order.paymentMethod ?? 'N/A',
                    Icons.credit_card,
                    isArabic,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    local.status,
                    _getStatusText(order.status ?? '', local),
                    Icons.info_outline,
                    isArabic,
                    statusColor: _getStatusColor(order.status ?? ''),
                    showStatusArrow: true,
                    currentStatus: order.status ?? '',
                    onStatusUpdate: (newStatus) {
                      context.read<OrdersCubit>().updateOrderStatus(order.id ?? '', newStatus);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Order Items
            _buildSection(
              title: '${local.order_items} (${order.orderItems?.length ?? 0})',
              icon: Icons.shopping_bag_outlined,
              child: Column(
                children: order.orderItems?.map((item) => _buildOrderItem(item, local, isArabic)).toList() ?? [],
              ),
            ),
            const SizedBox(height: 30),

            // Close Details Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      local.close,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  color: Colors.green,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon,
    bool isArabic, {
    Color? statusColor,
    bool showStatusArrow = false,
    String? currentStatus,
    Function(String)? onStatusUpdate,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 14,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$label:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (showStatusArrow && currentStatus != null && onStatusUpdate != null)
                _buildStatusWithArrow(value, statusColor, currentStatus, onStatusUpdate)
              else
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: statusColor ?? Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusWithArrow(String statusText, Color? statusColor, String currentStatus, Function(String) onStatusUpdate) {
    final nextStatus = _getNextStatus(currentStatus);
    final canProgress = nextStatus != null;
    final color = statusColor ?? Colors.grey;

    return PopupMenuButton<String>(
      onSelected: (String newStatus) {
        onStatusUpdate(newStatus);
      },
      enabled: canProgress,
      offset: const Offset(0, 45), // Show dropdown below the status
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      splashRadius: 0,
      itemBuilder: (BuildContext context) {
        if (!canProgress) return [];
        
        final nextStatusColor = _getStatusColor(nextStatus);
        final local = AppLocalizations.of(context)!;
        
        return [
          PopupMenuItem<String>(
            value: nextStatus,
            padding: const EdgeInsets.all(0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: nextStatusColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: nextStatusColor.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: nextStatusColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: nextStatusColor.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Change to ${_getStatusText(nextStatus, local)}',
                      style: TextStyle(
                        color: nextStatusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: nextStatusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: nextStatusColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(24),
              border: canProgress 
                  ? Border.all(
                      color: color.withValues(alpha: 0.25), 
                      width: 1.5
                    ) 
                  : Border.all(
                      color: color.withValues(alpha: 0.12), 
                      width: 1
                    ),
              boxShadow: canProgress ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ] : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  statusText,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                if (canProgress) ...[
                  const SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: color.withValues(alpha: 0.8),
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String? _getNextStatus(String currentStatus) {
    const statusSequence = ['PENDING', 'CONFIRMED', 'PROCESSING', 'FINISHPROCESSING', 'SHIPPED'];
    final currentIndex = statusSequence.indexOf(currentStatus.toUpperCase());
    if (currentIndex >= 0 && currentIndex < statusSequence.length - 1) {
      return statusSequence[currentIndex + 1];
    }
    return null;
  }

  Widget _buildOrderItem(OrderItem item, AppLocalizations local, bool isArabic) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.laptop_mac,
              color: Colors.purple,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName ?? 'Unknown Product',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${local.quantity}: ${item.quantity ?? 0}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.subtotal?.toStringAsFixed(2) ?? '0.00',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                '${item.price?.toStringAsFixed(2) ?? '0.00'} ${_getCurrency(local, null)} ${local.price}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getCurrency(AppLocalizations local, BuildContext? context) {
    if (context != null) {
      final locale = Localizations.localeOf(context);
      return locale.languageCode == 'ar' ? 'ج.م' : 'EGP';
    }
    return 'EGP';
  }

  String _getStatusText(String status, AppLocalizations local) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return local.pending;
      case 'CONFIRMED':
        return local.completed; // Using completed as closest match
      case 'PROCESSING':
        return local.processing;
      case 'FINISHPROCESSING':
        return local.finish_processing;
      case 'SHIPPED':
        return local.shipped;
      case 'DELIVERED':
        return local.delivered;
      case 'CANCELLED':
        return local.cancelled;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.blue;
      case 'PROCESSING':
        return Colors.purple;
      case 'FINISHPROCESSING':
        return Colors.indigo;
      case 'SHIPPED':
        return Colors.teal;
      case 'DELIVERED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}