import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class DeliveryNotificationsScreen extends StatelessWidget {
  const DeliveryNotificationsScreen({super.key});

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
          'Notifications',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildNotificationCard(
            title: 'Account Approved',
            message:
                'Congratulations! Your delivery account has been approved by admin. You can now start accepting deliveries.',
            time: '12/31/2025, 10:45:01 PM',
            isNew: true,
            icon: Icons.check_circle,
            iconColor: const Color(0xFF10B981),
            iconBgColor: const Color(0xFFECFDF5),
          ),

          const SizedBox(height: 16),

          _buildNotificationCard(
            title: 'Order Completed',
            message:
                'Order 019b22ae-728c-7e70-af73-3e0fab32958c has finished processing and is ready for delivery.',
            time: '12/30/2025, 8:30 AM',
            isNew: false,
            icon: Icons.local_shipping,
            iconColor: const Color(0xFF3B82F6),
            iconBgColor: const Color(0xFFEFF6FF),
          ),

          const SizedBox(height: 16),

          _buildNotificationCard(
            title: 'New Order Available',
            message:
                'A new order is available for pickup in your area. Check the available orders section.',
            time: '12/29/2025, 2:15 PM',
            isNew: false,
            icon: Icons.inventory_2,
            iconColor: const Color(0xFF8B5CF6),
            iconBgColor: const Color(0xFFF3F4F6),
          ),

          const SizedBox(height: 16),

          _buildNotificationCard(
            title: 'Delivery Completed',
            message:
                'You have successfully completed delivery for order #d5890023. Payment has been processed.',
            time: '12/28/2025, 6:45 PM',
            isNew: false,
            icon: Icons.done_all,
            iconColor: const Color(0xFF10B981),
            iconBgColor: const Color(0xFFECFDF5),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required bool isNew,
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isNew ? const Color(0xFFECFDF5) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            isNew ? Border.all(color: const Color(0xFF10B981), width: 1) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color:
                              isNew ? const Color(0xFF065F46) : Colors.black87,
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14,
                    color: isNew ? const Color(0xFF059669) : Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: isNew ? const Color(0xFF059669) : Colors.grey[500],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
