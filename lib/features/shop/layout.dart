import 'package:flutter/material.dart';
import 'package:tech_restore/features/shop/tabs/dashboard_screen.dart';
import 'package:tech_restore/features/shop/tabs/devices_screen.dart';
import 'package:tech_restore/features/shop/tabs/inventory_screen.dart';
import 'package:tech_restore/features/shop/tabs/offers_screen.dart';
import 'package:tech_restore/features/shop/tabs/orders_screen.dart';
import 'package:tech_restore/features/shop/tabs/repair_screen.dart';
import 'package:tech_restore/features/shop/tabs/support_screen.dart';
import 'package:tech_restore/features/shop/tabs/transactions_screen.dart';
import '../../core/l10n/translation/app_localizations.dart';
import '../../core/widgets/drawer_widget.dart';

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
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _getTitle(_selectedIndex,local),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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

  String _getTitle(int index, AppLocalizations local) {
    switch (index) {
      case 0:
        return local.dashboard;
      case 1:
        return local.repair;
      case 2:
        return local.devices;
      case 3:
        return local.orders;
      case 4:
        return local.invoices;
      case 5:
        return local.inventory;
      case 6:
        return local.offers;
      case 7:
        return local.support;
        default:
        return "";
    }
  }
}
