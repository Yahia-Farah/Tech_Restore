import 'package:flutter/material.dart';
import 'package:tech_restore/ui/shop/tabs/dashboard_screen.dart';
import 'package:tech_restore/ui/shop/tabs/devices_screen.dart';
import 'package:tech_restore/ui/shop/tabs/orders_screen.dart';
import 'package:tech_restore/ui/shop/tabs/repair_screen.dart';
import 'package:tech_restore/ui/shop/tabs/transactions_screens.dart';

import '../../core/assset_manager.dart';
import '../../core/color_manager.dart';
import '../../core/reusable_components/drawer_widget.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RepairScreen(),
    const DevicesScreen(),
    const OrdersScreen(),
    const TransactionsScreen(),
    const InventoryScreen(),
    const OffersScreen(),
    const SupportScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(width: 20),
        ],
      ),
      drawer: DrawerWidget(onItemTapped: _onItemTapped),
      body: IndexedStack(index: _selectedIndex, children: _screens),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return "لوحة التحكم";
      case 1:
        return "التصليح";
      case 2:
        return "الاجهزة";
      case 3:
        return "الطلبات";
      case 4:
        return "الفواتير";
      case 5:
        return "جرد";
      case 6:
        return "العروض";
      case 7:
        return "الدعم";
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
