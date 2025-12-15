import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/dashboard_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/devices_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/inventory_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/offers_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/orders_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/repair_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/subscriptions_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/support_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/tabs/transactions_screen.dart';
import 'package:tech_restore/features/shop/presentation/view/widgets/drawer_widget.dart';
import 'dart:async';
import 'package:tech_restore/features/shop/presentation/view/widgets/notifications_screen.dart';
import 'package:tech_restore/features/shop/presentation/viewmodel/devices_cubit.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../data/repositories/shop_repository.dart';
import '../../../../core/config/di.dart';
import '../viewmodel/offers_cubit.dart';
import '../viewmodel/inventory_cubit.dart';
import '../viewmodel/notifications_cubit.dart';
import '../viewmodel/notifications_state.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({super.key});

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  int _selectedIndex = 0;
  Timer? _notificationsTimer;
  late NotificationsCubit _notificationsCubit;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const RepairScreen(),
    BlocProvider(
      create: (context) => DevicesCubit(getIt<ShopRepository>()),
      child: const DevicesScreen(),
    ),
    const OrdersScreen(),
    const TransactionsScreen(),
    BlocProvider(
      create: (context) => InventoryCubit(getIt<ShopRepository>()),
      child: const InventoryScreen(),
    ),
    const SubscriptionsScreen(),
    BlocProvider(
      create: (context) => OffersCubit(getIt<ShopRepository>()),
      child: const OffersScreen(),
    ),
    const SupportScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationsCubit = getIt<NotificationsCubit>();
    _notificationsCubit.fetchNotifications();
    _startNotificationsTimer();
  }

  void _startNotificationsTimer() {
    _notificationsTimer?.cancel();
    _notificationsTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) {
        _notificationsCubit.fetchNotifications();
      }
    });
  }

  @override
  void dispose() {
    _notificationsTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _getTitle(_selectedIndex, local),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          BlocProvider.value(
            value: _notificationsCubit,
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                int notificationCount = 0;
                if (state is NotificationsLoaded) {
                  notificationCount = state.notifications.length;
                }

                return Stack(
                  children: [
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                              value: context.read<NotificationsCubit>(),
                              child: const NotificationsScreen(),
                            ),
                          ),
                        );
                        if (context.mounted) {
                          context.read<NotificationsCubit>().fetchNotifications();
                        }
                      },
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        right: 8,
                        top: 3,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            notificationCount > 99 ? '99+' : notificationCount.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          SizedBox(width: 15),
          CircleAvatar(child: Text("M")),
          SizedBox(width: 10),
          Center(
            child: Text("Mahmoud Ali", style: TextStyle(color: Colors.white,fontSize: 16)),
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
        return local.subs;
      case 7:
        return local.offers;
      case 8:
        return local.support;
      default:
        return "";
    }
  }
}
