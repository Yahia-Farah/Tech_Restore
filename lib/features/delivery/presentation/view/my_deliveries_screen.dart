import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class MyDeliveriesScreen extends StatelessWidget {
  const MyDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
        ),
        title: const Text(
          'My Deliveries',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Filter deliveries
            },
            icon: const Icon(Icons.filter_list, color: Colors.black54),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Stats Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_shipping_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1 Active Delivery',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Track your ongoing deliveries',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Active Delivery Card
          _buildDeliveryCard(
            context,
            orderId: '#d5890023',
            customerName: 'Ahmed Mohamed',
            pickupAddress: '11th street, Cairo',
            deliveryAddress: '50th Street, Cairo',
            totalPrice: '1999.99 EGP',
            orderDate: '12/28/2025, 6:45 PM',
            status: 'IN_TRANSIT',
            isActive: true,
          ),

          const SizedBox(height: 16),

          // Completed Deliveries Section
          const Text(
            'Completed Deliveries',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 16),

          _buildDeliveryCard(
            context,
            orderId: '#01998f01',
            customerName: 'Sara Ahmed',
            pickupAddress: '11th street, Cairo',
            deliveryAddress: '25th Street, Cairo',
            totalPrice: '18000 EGP',
            orderDate: '9/28/2025, 8:28 AM',
            status: 'DELIVERED',
            isActive: false,
          ),

          const SizedBox(height: 16),

          _buildDeliveryCard(
            context,
            orderId: '#0199ab2b',
            customerName: 'Mohamed Ali',
            pickupAddress: '11th street, Cairo',
            deliveryAddress: '30th Street, Cairo',
            totalPrice: '28000 EGP',
            orderDate: '10/1/2025, 6:30 PM',
            status: 'DELIVERED',
            isActive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard(
      BuildContext context, {
        required String orderId,
        required String customerName,
        required String pickupAddress,
        required String deliveryAddress,
        required String totalPrice,
        required String orderDate,
        required String status,
        required bool isActive,
      }) {
    Color statusColor;
    Color statusBgColor;
    IconData statusIcon;

    switch (status) {
      case 'IN_TRANSIT':
        statusColor = const Color(0xFF3B82F6);
        statusBgColor = const Color(0xFFEFF6FF);
        statusIcon = Icons.local_shipping;
        break;
      case 'DELIVERED':
        statusColor = const Color(0xFF10B981);
        statusBgColor = const Color(0xFFECFDF5);
        statusIcon = Icons.check_circle;
        break;
      default:
        statusColor = const Color(0xFF8B5CF6);
        statusBgColor = const Color(0xFFF3F4F6);
        statusIcon = Icons.access_time;
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isActive ? Border.all(color: AppColors.primary, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(statusIcon, color: statusColor, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Order $orderId',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      customerName,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status.replaceAll('_', ' '),
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Order Details
          _buildDetailRow(
            icon: Icons.access_time,
            label: 'Order Date',
            value: orderDate,
            iconColor: const Color(0xFF8B5CF6),
          ),

          const SizedBox(height: 12),

          _buildDetailRow(
            icon: Icons.payments_outlined,
            label: 'Total Amount',
            value: totalPrice,
            iconColor: const Color(0xFF10B981),
          ),

          const SizedBox(height: 20),

          // Addresses Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _buildAddressRow(
                  icon: Icons.store_outlined,
                  label: 'Picked up from',
                  address: pickupAddress,
                  iconColor: const Color(0xFFEF4444),
                ),

                const SizedBox(height: 16),

                Container(height: 1, color: Colors.grey.shade200),

                const SizedBox(height: 16),

                _buildAddressRow(
                  icon: Icons.location_on_outlined,
                  label: status == 'DELIVERED' ? 'Delivered to' : 'Delivering to',
                  address: deliveryAddress,
                  iconColor: const Color(0xFF10B981),
                ),
              ],
            ),
          ),

          if (isActive) ...[
            const SizedBox(height: 24),
            // Action Button for active deliveries
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showUpdateStatusDialog(context, orderId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Update Status',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: iconColor),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressRow({
    required IconData icon,
    required String label,
    required String address,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                address,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showUpdateStatusDialog(BuildContext context, String orderId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Delivery Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Update status for order $orderId'),
            const SizedBox(height: 16),
            // Status options
            ListTile(
              leading: const Icon(Icons.check_circle, color: Color(0xFF10B981)),
              title: const Text('Mark as Delivered'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Order $orderId marked as delivered!'),
                    backgroundColor: const Color(0xFF10B981),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}