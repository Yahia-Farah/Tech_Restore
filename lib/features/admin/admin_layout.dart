import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/config/di.dart';
import 'package:tech_restore/features/admin/tabs/manage-dashboard/presentation/view/admin_dashboard_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-dashboard/presentation/viewmodel/admin_stats_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/view/admin_repair_screen.dart';
import 'package:tech_restore/features/admin/tabs/promotional_offers.dart';
import 'package:tech_restore/features/admin/tabs/reviews_screen.dart';
import 'package:tech_restore/features/admin/tabs/support_screen.dart';
import 'package:tech_restore/features/admin/tabs/transaction_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/view/users_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/get_users_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/get_shops_cubit.dart';
import 'package:tech_restore/features/admin/widgets/admin_drawer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/l10n/translation/app_localizations.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<AdminLayout> {
  int _selectedIndex = 0;

  List<Widget> get _screens => [
    BlocProvider(
      create: (context) => getIt<AdminStatsCubit>(),
      child: const AdminDashboardScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<GetUsersCubit>(),
      child: const UsersScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<GetShopsCubit>(),
      child: const AdminRepairScreen(),
    ),
    AdminTransactionsScreen(),
    AdminReviewsScreen(),
    AdminPromotionsScreen(),
    AdminSupportScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isDashboard = _selectedIndex == 0;
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: isDashboard
            ? Row(
                children: [
                  Icon(
                    Icons.show_chart,
                    color: const Color(0xFF456006),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    local.admin_dashboard,
                    style: const TextStyle(
                      color: Color(0xFF456006),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            : Text(
                _getTitle(_selectedIndex),
                style: const TextStyle(
                  color: AppColors.primary,
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
                  color: AppColors.primary,
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
          const SizedBox(width: 10),
        ],
      ),
      drawer: AdminDrawerWidget(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
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
