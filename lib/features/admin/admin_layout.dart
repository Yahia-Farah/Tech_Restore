import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/config/di.dart';
import 'package:tech_restore/features/admin/tabs/manage-dashboard/presentation/view/admin_dashboard_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-dashboard/presentation/viewmodel/admin_stats_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-delivery/presentation/view/delivery_admin_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/view/admin_repair_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/presentation/view/admin_reviews_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/view/admin_promotional_offers_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-categories/presentation/view/admin_categories_screen.dart';
import 'package:tech_restore/features/admin/tabs/support_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-transaction/presentation/view/transaction_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/view/users_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-assigner/presentation/view/admin_assigner_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-assignment-logs/presentation/view/admin_assignment_logs_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-subscription/presentation/view/admin_subscription_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-subscription/presentation/viewmodel/subscription_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-products/presentation/view/admin_products_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-repair-requests/presentation/view/admin_repair_requests_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-offers/presentation/view/admin_offers_screen.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/get_users_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/get_shops_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-reviews/presentation/viewmodel/get_reviews_cubit.dart';
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
    // Dashboard (index 0)
    BlocProvider(
      create: (context) => getIt<AdminStatsCubit>(),
      child: const AdminDashboardScreen(),
    ),
    // Users (index 1)
    BlocProvider(
      create: (context) => getIt<GetUsersCubit>(),
      child: const UsersScreen(),
    ),
    // Shop section: Stores (index 2)
    BlocProvider(
      create: (context) => getIt<GetShopsCubit>(),
      child: const AdminRepairScreen(),
    ),
    // Shop section: Subscription (index 3)
    BlocProvider(
      create: (context) => getIt<SubscriptionCubit>(),
      child: const AdminSubscriptionScreen(),
    ),
    // Shop section: Products (index 4)
    const AdminProductsScreen(),
    // Shop section: Repair Requests (index 5)
    const AdminRepairRequestsScreen(),
    // Shop section: Offers (index 6)
    const AdminOffersScreen(),
    // Shop section: Reviews (index 7)
    BlocProvider(
      create: (context) => getIt<GetReviewsCubit>(),
      child: const AdminReviewsScreen(),
    ),
    // Categories (index 8)
    BlocProvider(
      create: (context) => getIt<CategoriesCubit>(),
      child: const AdminCategoriesScreen(),
    ),
    // Transactions (index 9)
    BlocProvider(
      create: (context) => getIt<TransactionsCubit>(),
      child: const AdminTransactionsScreen(),
    ),
    // Delivery (index 10)
    BlocProvider(
      create: (context) => getIt<DeliveriesCubit>(),
      child: const DeliveryAdminScreen(),
    ),
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
                : _selectedIndex == 8
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
    final local = AppLocalizations.of(context)!;
    switch (index) {
      case 0:
        return local.dashboard;
      case 1:
        return local.users;
      case 2:
        return local.stores;
      case 3:
        return local.subscription;
      case 4:
        return local.products;
      case 5:
        return local.repair_requests;
      case 6:
        return local.offers;
      case 7:
        return local.reviews;
      case 8:
        return local.categories;
      case 9:
        return local.transactions;
      case 10:
        return "Delivery"; // TODO: Add to localization
      default:
        return "";
    }
  }
}
