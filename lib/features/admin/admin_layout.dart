import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/config/di.dart';
import 'package:tech_restore/features/admin/tabs/manage-dashboard/presentation/view/admin_dashboard_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-dashboard/presentation/viewmodel/admin_stats_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-delivery/presentation/view/delivery_admin_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/view/admin_repair_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/view/admin_reviews_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/view/admin_promotional_offers_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-categories/presentation/view/admin_categories_screen.dart';
import 'package:tech_restore/features/admin/tabs/support_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-transaction/presentation/view/transaction_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/view/users_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-assigner/presentation/view/admin_assigner_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-assignment-logs/presentation/view/admin_assignment_logs_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/get_users_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/get_shops_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-categories/presentation/viewmodel/categories_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-transaction/presentation/viewmodel/transactions_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-delivery/presentation/viewmodel/deliveries_cubit.dart';
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
    // Shop section: Stores (index 2)
    BlocProvider(
      create: (context) => getIt<GetShopsCubit>(),
      child: const AdminRepairScreen(),
    ),
    // Shop section: Reviews (index 3)
    const AdminReviewsScreen(),
    // Shop section: Promotional Offers (index 4)
    const AdminPromotionsScreen(),
    // Transactions (index 5)
    BlocProvider(
      create: (context) => getIt<TransactionsCubit>(),
      child: const AdminTransactionsScreen(),
    ),
    // Support (index 6)
    AdminSupportScreen(),
    // Categories (index 7)
    BlocProvider(
      create: (context) => getIt<CategoriesCubit>(),
      child: const AdminCategoriesScreen(),
    ),
    // Delivery (index 8)
    BlocProvider(
      create: (context) => getIt<DeliveriesCubit>(),
      child: const DeliveryAdminScreen(),
    ),
    // Assigner (index 9)
    const AdminAssignerScreen(),
    // Assignment Logs (index 10)
    const AdminAssignmentLogsScreen(),
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
    final isUsersScreen = _selectedIndex == 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:
            isDashboard
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
                : isUsersScreen
                ? Row(
                  children: [
                    Icon(
                      Icons.people_outline,
                      color: const Color(0xFF456006),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      local.user_management,
                      style: const TextStyle(
                        color: Color(0xFF456006),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
                : _selectedIndex == 7
                ? Row(
                  children: [
                    Icon(Icons.list, color: AppColors.primary[70], size: 30),
                    const SizedBox(width: 8),
                    Text(
                      local.categories,
                      style: TextStyle(
                        color: AppColors.primary[70],
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
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
        return "Stores";
      case 3:
        return "Reviews";
      case 4:
        return "Promotional Offers";
      case 5:
        return "Transaction";
      case 6:
        return "Support";
      case 7:
        return "Categories";
      case 8:
        return "Delivery";
      case 9:
        return "Assigner";
      case 10:
        return "Assignment Logs";
      default:
        return "";
    }
  }
}
