import 'package:flutter/material.dart';

import 'AvailableOrdersScreen.dart';
import 'AvailableRepairsScreen.dart';
import 'MyDeliveriesScreen.dart';
import 'MyRepairDeliveriesScreen.dart';

class DeliveryDashboardScreen extends StatelessWidget {
  static const String routeName = "delivery";
  const DeliveryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5748E6),
        elevation: 0,
        title: const Text("Delivery Dashboard"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Delivery Dashboard",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "Your quick overview of orders and repairs",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            /// ---------- BUTTON ROW 1 ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardButton(
                  title: "Available Orders",
                  value: "0",
                  icon: Icons.inventory_2_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AvailableOrdersScreen(),
                      ),
                    );
                  },
                ),
                DashboardButton(
                  title: "My Deliveries",
                  value: "5",
                  icon: Icons.local_shipping_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyDeliveriesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// ---------- BUTTON ROW 2 ----------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DashboardButton(
                  title: "Available Repairs",
                  value: "0",
                  icon: Icons.build_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AvailableRepairsScreen(),
                      ),
                    );
                  },
                ),
                DashboardButton(
                  title: "My Repair Deliveries",
                  value: "2",
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyRepairDeliveriesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 25),

            const Text(
              "Recent Activity",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const ActivityItem(
              text: "Order #0190a82b - SHIPPED (Price: 28000 EGP)",
            ),
            const ActivityItem(
              text: "Order #0190a79c - SHIPPED (Price: 28000 EGP)",
            ),
            const ActivityItem(
              text: "Order #0190a978 - DEVICE_DELIVERED (Price: 18000 EGP)",
            ),
            const ActivityItem(
              text: "Repair #01998ab5 - DEVICE_DELIVERED",
            ),
            const ActivityItem(
              text: "Repair #01998af3 - DEVICE_DELIVERED",
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardButton extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const DashboardButton({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.sizeOf(context).width / 2 - 22,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: Color(0xFF5748E6)),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String text;

  const ActivityItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 12, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }
}







