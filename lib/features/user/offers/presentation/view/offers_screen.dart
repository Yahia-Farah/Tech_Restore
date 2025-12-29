import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offers = [
      {
        'title': 'Back to School Sale 1',
        'description': 'Discount on all electronics for the season',
        'status': 'ACTIVE',
        'validFrom': '9/10/2025',
        'validTo': '9/30/2025',
        'shop': 'Tech Restore Shop',
        'discount': '20%',
        'category': 'Electronics',
      },
      {
        'title': 'Back to School Sale 2',
        'description': 'Discount on all electronics for the season',
        'status': 'EXPIRED',
        'validFrom': '9/10/2025',
        'validTo': '9/30/2025',
        'shop': 'Tech Restore Shop',
        'discount': '15%',
        'category': 'Accessories',
      },
      {
        'title': 'Back to School Sale 3',
        'description': 'Discount on all electronics for the season',
        'status': 'SCHEDULED',
        'validFrom': '9/10/2025',
        'validTo': '9/30/2025',
        'shop': 'Tech Restore Shop',
        'discount': '25%',
        'category': 'Repairs',
      },
      {
        'title': 'iPhone Screen Repair Special',
        'description': 'Get your iPhone screen fixed at a discounted price',
        'status': 'ACTIVE',
        'validFrom': '9/15/2025',
        'validTo': '10/15/2025',
        'shop': 'Mobile Masters',
        'discount': '30%',
        'category': 'Screen Repair',
      },
      {
        'title': 'Laptop Battery Replacement',
        'description': 'Professional laptop battery replacement service',
        'status': 'ACTIVE',
        'validFrom': '9/01/2025',
        'validTo': '12/31/2025',
        'shop': 'Laptop Clinic',
        'discount': 'EGP 499',
        'category': 'Battery',
      },
      {
        'title': 'Gaming Console Repair',
        'description': 'Expert repair services for all gaming consoles',
        'status': 'SCHEDULED',
        'validFrom': '10/01/2025',
        'validTo': '11/30/2025',
        'shop': 'Gaming Hub',
        'discount': '40%',
        'category': 'Gaming',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
        ),
        title: Text(
          'Special Offers',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Deals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: offers.length,
                itemBuilder: (context, index) {
                  final offer = offers[index];
                  return _buildOfferCard(offer);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, String> offer) {
    Color statusColor;
    Color statusBgColor;

    switch (offer['status']) {
      case 'ACTIVE':
        statusColor = Colors.green;
        statusBgColor = Colors.green.withValues(alpha: 0.1);
        break;
      case 'EXPIRED':
        statusColor = Colors.red;
        statusBgColor = Colors.red.withValues(alpha: 0.1);
        break;
      case 'SCHEDULED':
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withValues(alpha: 0.1);
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey.withValues(alpha: 0.1);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          // Header with title and status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  offer['title']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
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
                  offer['status']!,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Description
          Text(
            offer['description']!,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),

          // Special Deal Button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_offer, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Special Deal - ${offer['discount']} OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Details section
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  Icons.calendar_today,
                  'Valid: ${offer['validFrom']} - ${offer['validTo']}',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildDetailItem(Icons.store, offer['shop']!)),
            ],
          ),
          const SizedBox(height: 16),

          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  offer['status'] == 'ACTIVE'
                      ? () {
                        // Handle claim offer
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    offer['status'] == 'ACTIVE'
                        ? AppColors.primary
                        : Colors.grey[300],
                foregroundColor:
                    offer['status'] == 'ACTIVE'
                        ? Colors.white
                        : Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                offer['status'] == 'ACTIVE'
                    ? 'Claim Offer'
                    : offer['status'] == 'EXPIRED'
                    ? 'Expired'
                    : 'Coming Soon',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
