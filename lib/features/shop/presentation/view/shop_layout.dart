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
import '../../../../core/routes/route_names.dart';
import '../../data/repositories/shop_repository.dart';
import '../../../../core/config/di.dart';
import '../viewmodel/offers_cubit.dart';
import '../viewmodel/inventory_cubit.dart';
import '../viewmodel/notifications_cubit.dart';
import '../viewmodel/notifications_state.dart';
import '../viewmodel/orders_cubit.dart';
import '../viewmodel/shop_chat_cubit.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({super.key});

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {
  int _selectedIndex = 0;
  Timer? _notificationsTimer;
  late NotificationsCubit _notificationsCubit;

  // Track which screens have been initialized
  final Set<int> _initializedScreens = {
    0,
  }; // Dashboard is initialized by default

  // Store cubit instances to reuse them
  DevicesCubit? _devicesCubit;
  InventoryCubit? _inventoryCubit;
  OffersCubit? _offersCubit;
  OrdersCubit? _ordersCubit;
  ShopChatCubit? _supportCubit;

  // Track which screens have loaded data to avoid reloading
  final Set<int> _dataLoadedScreens = <int>{};

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Initialize screen if not already initialized
      if (!_initializedScreens.contains(index)) {
        _initializedScreens.add(index);
        _initializeScreen(index);
      }
    });
  }

  void _initializeScreen(int index) {
    switch (index) {
      case 2: // Devices
        if (_devicesCubit == null) {
          _devicesCubit = DevicesCubit(getIt<ShopRepository>());
          // Load data only once when cubit is first created
          _loadScreenData(index);
        }
        break;
      case 3: // Orders
        if (_ordersCubit == null) {
          _ordersCubit = OrdersCubit(getIt<ShopRepository>());
          // Load data only once when cubit is first created
          _loadScreenData(index);
        }
        break;
      case 5: // Inventory
        if (_inventoryCubit == null) {
          _inventoryCubit = InventoryCubit(getIt<ShopRepository>());
          // Load data only once when cubit is first created
          _loadScreenData(index);
        }
        break;
      case 7: // Offers
        if (_offersCubit == null) {
          _offersCubit = OffersCubit(getIt<ShopRepository>());
          // Load data only once when cubit is first created
          _loadScreenData(index);
        }
        break;
      case 8: // Support
        if (_supportCubit == null) {
          _supportCubit = getIt<ShopChatCubit>();
          // Load data only once when cubit is first created
          _loadScreenData(index);
        }
        break;
    }
  }

  void _loadScreenData(int index) {
    if (_dataLoadedScreens.contains(index)) return; // Already loaded

    _dataLoadedScreens.add(index);

    switch (index) {
      case 2: // Devices
        _devicesCubit?.getAllDevices(isRefresh: true);
        break;
      case 3: // Orders
        _ordersCubit?.getAllOrders(isRefresh: true);
        break;
      case 5: // Inventory
        _inventoryCubit?.searchInventory(isRefresh: true);
        _inventoryCubit?.loadInventoryStats();
        break;
      case 7: // Offers
        _offersCubit?.getAllOffers(isRefresh: true);
        break;
      case 8: // Support
        _supportCubit?.fetchSessions();
        break;
    }
  }

  List<Widget> _buildScreens() {
    return [
      const DashboardScreen(), // 0
      const RepairScreen(), // 1
      _devicesCubit !=
              null // 2
          ? BlocProvider.value(
            value: _devicesCubit!,
            child: const DevicesScreen(),
          )
          : const Center(child: CircularProgressIndicator()),
      _ordersCubit !=
              null // 3
          ? BlocProvider.value(
            value: _ordersCubit!,
            child: const OrdersScreenContent(),
          )
          : const Center(child: CircularProgressIndicator()),
      const TransactionsScreen(), //// 4
      _inventoryCubit !=
              null // 5
          ? BlocProvider.value(
            value: _inventoryCubit!,
            child: const InventoryScreen(),
          )
          : const Center(child: CircularProgressIndicator()),
      const SubscriptionsScreen(), // 6
      _offersCubit !=
              null // 7
          ? BlocProvider.value(
            value: _offersCubit!,
            child: const OffersScreen(),
          )
          : const Center(child: CircularProgressIndicator()),
      _supportCubit !=
              null // 8
          ? BlocProvider.value(
            value: _supportCubit!,
            child: const SupportScreenContent(),
          )
          : const Center(child: CircularProgressIndicator()),
    ];
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
    _devicesCubit?.close();
    _inventoryCubit?.close();
    _offersCubit?.close();
    _ordersCubit?.close();
    _supportCubit?.close();
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
                            builder:
                                (_) => BlocProvider.value(
                                  value: context.read<NotificationsCubit>(),
                                  child: const NotificationsScreen(),
                                ),
                          ),
                        );
                        if (context.mounted) {
                          context
                              .read<NotificationsCubit>()
                              .fetchNotifications();
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
                            notificationCount > 99
                                ? '99+'
                                : notificationCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          SizedBox(width: 15),
          PopupMenuButton<String>(
            icon: const Icon(Icons.person, color: Colors.white, size: 32),
            offset: const Offset(0, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            color: Colors.white,
            shadowColor: Colors.black26,
            onSelected: (String value) {
              switch (value) {
                case 'profile':
                  Navigator.pushNamed(context, AppRoutes.shopProfile);
                  break;
                case 'addresses':
                  Navigator.pushNamed(context, AppRoutes.addresses);
                  break;
              }
            },
            itemBuilder:
                (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'profile',
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          local.profile,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(height: 1),
                  PopupMenuItem<String>(
                    value: 'addresses',
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.green,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          local.address,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
          SizedBox(width: 20),
        ],
      ),
      drawer: DrawerWidget(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      body: IndexedStack(index: _selectedIndex, children: _buildScreens()),
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
