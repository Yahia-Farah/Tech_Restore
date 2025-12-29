import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../../core/config/di.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../profile/presentation/viewmodel/profile_cubit.dart';
import '../tabs/account_tab/profile_tab.dart';
import '../tabs/explore_tab/explore_tab.dart';
import '../tabs/home_tab/home_tab.dart';
import '../tabs/track_tab/track_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Track which screens have been initialized
  final Set<int> _initializedScreens = {
    0,
  }; // Home tab is initialized by default

  // Store cubit instances to reuse them
  ProfileCubit? _profileCubit;

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
      case 3: // Account
        if (_profileCubit == null) {
          _profileCubit = getIt<ProfileCubit>();
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
      case 3: // Account
        _profileCubit?.getUserProfile();
        break;
    }
  }

  List<Widget> _buildScreens() {
    return [
      const HomeTab(), // 0
      Exploretab(), // 1
      const Tracktab(), // 2
      _profileCubit !=
              null // 3
          ? BlocProvider.value(value: _profileCubit!, child: ProfileTab())
          : const Center(child: CircularProgressIndicator()),
    ];
  }

  Widget _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.primary : Colors.grey[600],
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : Colors.grey[600],
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _profileCubit?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          color: Colors.white,
          elevation: 0,
          child: Container(
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: local.home,
                  index: 0,
                ),
                _buildNavItem(
                  icon: Icons.search_outlined,
                  activeIcon: Icons.search,
                  label: local.explore,
                  index: 1,
                ),
                const SizedBox(width: 50), // Space for FAB
                _buildNavItem(
                  icon: Icons.local_shipping_outlined,
                  activeIcon: Icons.local_shipping,
                  label: local.repairStatue,
                  index: 2,
                ),
                _buildNavItem(
                  icon: Icons.account_circle_outlined,
                  activeIcon: Icons.account_circle,
                  label: local.profile,
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.primary[70]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(32.5),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.cart);
            },
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                // Cart badge
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 20,
                      minHeight: 20,
                    ),
                    child: const Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(index: _selectedIndex, children: _buildScreens()),
    );
  }
}
