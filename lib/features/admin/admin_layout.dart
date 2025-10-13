import 'package:flutter/material.dart';
import 'package:tech_restore/features/admin/tabs/admin_dashboard_screen.dart';
import 'package:tech_restore/features/admin/tabs/admin_repair_screen.dart';
import 'package:tech_restore/features/admin/tabs/promotional_offers.dart';
import 'package:tech_restore/features/admin/tabs/reviews_screen.dart';
import 'package:tech_restore/features/admin/tabs/support_screen.dart';
import 'package:tech_restore/features/admin/tabs/transaction_screen.dart';
import 'package:tech_restore/features/admin/tabs/users_screen.dart';
import 'package:tech_restore/features/admin/widgets/admin_drawer.dart';


class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<AdminLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    AdminDashboardScreen(),
    UsersScreen(),
    AdminRepairScreen(),
    AdminTransactionsScreen(),
    AdminReviewsScreen(),
    AdminPromotionsScreen(),
    AdminSupportScreen(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          _getTitle(_selectedIndex),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Stack(
            children: [
              IconButton(
                iconSize: 32,
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 3,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    "3",
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          CircleAvatar(child: Text("M")),
          SizedBox(width: 10),
          Center(
            child: Text("Mahmoud Ali", style: TextStyle(color: Colors.black)),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: AdminDrawerWidget(onItemTapped: _onItemTapped, selectedIndex: _selectedIndex,),
      body: IndexedStack(index: _selectedIndex, children: _screens),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return "Dashboard";
      case 1:
        return "User";
      case 2:
        return "Repair Shop";
      case 3:
        return "Transaction";
      case 4:
        return "Reviews";
      case 5:
        return "Promotional offers";
      case 6:
        return "Support";
      default:
        return "";
    }
  }
}


class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Inventory Screen"));
  }
}

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("🏷️ Offers Screen"));
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("💬 Support Screen"));
  }
}
