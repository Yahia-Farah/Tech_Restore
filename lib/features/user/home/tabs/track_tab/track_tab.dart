import 'package:flutter/material.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';

class Tracktab extends StatefulWidget {
  const Tracktab({super.key});

  @override
  State<Tracktab> createState() => _TracktabState();
}

class _TracktabState extends State<Tracktab> {
  String selectedOrderId = 'Order #019b5667-8889-71a9-9242-c2fed5890823';

  final List<Map<String, String>> orders = [
    {
      'id': 'Order #019b5667-8889-71a9-9242-c2fed5890823',
      'status': 'DELIVERED',
    },
    {
      'id': 'Order #019b5667-8889-71a9-9242-c2fed5890824',
      'status': 'SHIPPED',
    },
    {
      'id': 'Order #019b5667-8889-71a9-9242-c2fed5890825',
      'status': 'PROCESSING',
    },
  ];

  final List<Map<String, dynamic>> statusUpdates = [
    {
      "status": "Pending",
      "icon": Icons.access_time,
      "isCompleted": true,
      "isCurrent": false,
    },
    {
      "status": "Confirmed",
      "icon": Icons.check_circle,
      "isCompleted": true,
      "isCurrent": false,
    },
    {
      "status": "Processing",
      "icon": Icons.settings,
      "isCompleted": true,
      "isCurrent": false,
    },
    {
      "status": "Finished Processing",
      "icon": Icons.check_circle,
      "isCompleted": true,
      "isCurrent": false,
    },
    {
      "status": "Shipped",
      "icon": Icons.local_shipping,
      "isCompleted": true,
      "isCurrent": false,
    },
    {
      "status": "Delivered",
      "icon": Icons.check_circle,
      "isCompleted": true,
      "isCurrent": true,
      "subtitle": "Current Status",
    },
  ];

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final selectedOrder = orders.firstWhere((order) => order['id'] == selectedOrderId);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
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
      body: Padding(
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
                    color: Colors.black.withOpacity(0.05),
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
                      value: order['id'],
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          '${order['id']} - ${order['status']}',
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
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Live Tracking: ${selectedOrder['id']}',
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
                                height: 56,
                                decoration: BoxDecoration(
                                  color: item['isCompleted']
                                      ? AppColors.primary
                                      : Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                  boxShadow: item['isCompleted'] ? [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
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
                                      color: item['isCompleted']
                                          ? AppColors.primary
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                  if (item['subtitle'] != null) ...[
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        item['subtitle'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary,
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
      ),
    );
  }
}