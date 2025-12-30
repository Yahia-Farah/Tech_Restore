import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/contants/app_images.dart';
import '../../../core/config/di.dart';
import '../../../core/l10n/translation/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/logout/viewmodel/logout_viewmodel.dart';
import '../../auth/logout/views/logout_widget.dart';

class AdminDrawerWidget extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AdminDrawerWidget({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });

  @override
  State<AdminDrawerWidget> createState() => _AdminDrawerWidgetState();
}

class _AdminDrawerWidgetState extends State<AdminDrawerWidget> {
  bool _isShopExpanded = true;

  bool _isShopItemSelected(int index) {
    return index >= 2 && index <= 7;
  }

  @override
  void didUpdateWidget(AdminDrawerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isShopItemSelected(widget.selectedIndex) && !_isShopExpanded) {
      setState(() {
        _isShopExpanded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Image.asset(AppImages.startScreen, height: 250),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  index: 0,
                  icon: Icons.dashboard_outlined,
                  text: local.dashboard,
                ),
                _buildDrawerItem(
                  index: 1,
                  icon: Icons.people_alt_outlined,
                  text: local.users,
                ),
                _buildExpandableShopSection(),
                _buildDrawerItem(
                  index: 8,
                  icon: Icons.list,
                  text: local.categories,
                ),
                _buildDrawerItem(
                  index: 9,
                  icon: Icons.attach_money_outlined,
                  text: local.transactions,
                ),
                _buildDrawerItem(
                  index: 10,
                  icon: Icons.local_shipping_outlined,
                  text: "Delivery", // TODO: Add to localization
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                local.logout,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => BlocProvider(
                        create: (context) => getIt<LogoutViewModel>(),
                        child: const LogoutDialogWidget(),
                      ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableShopSection() {
    final isShopSelected = _isShopItemSelected(widget.selectedIndex);
    var local = AppLocalizations.of(context)!;

    return ExpansionTile(
      leading: Icon(Icons.shopping_bag_outlined, color: AppColors.primary[70]),
      title: Text(
        local.shop,
        style: TextStyle(
          color: isShopSelected ? AppColors.primary : AppColors.black,
          fontSize: 16,
          fontWeight: isShopSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      initiallyExpanded: _isShopExpanded,
      onExpansionChanged: (expanded) {
        setState(() {
          _isShopExpanded = expanded;
        });
      },
      children: [
        _buildShopSubItem(index: 2, icon: Icons.store_outlined, text: local.stores),
        _buildShopSubItem(index: 3, icon: Icons.subscriptions_outlined, text: local.subscription),
        _buildShopSubItem(index: 4, icon: Icons.inventory_outlined, text: local.products),
        _buildShopSubItem(index: 5, icon: Icons.build_outlined, text: local.repair_requests),
        _buildShopSubItem(index: 6, icon: Icons.local_offer_outlined, text: local.offers),
        _buildShopSubItem(index: 7, icon: Icons.star_border, text: local.reviews),
      ],
    );
  }

  Widget _buildShopSubItem({
    required int index,
    required IconData icon,
    required String text,
  }) {
    final bool isSelected = index == widget.selectedIndex;

    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary[70], size: 20),
        title: Text(
          text,
          style: TextStyle(
            color: isSelected ? AppColors.primary : AppColors.black,
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: AppColors.primary.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: () => widget.onItemTapped(index),
      ),
    );
  }

  Widget _buildDrawerItem({
    required int index,
    required IconData icon,
    required String text,
  }) {
    final bool isSelected = index == widget.selectedIndex;

    return ListTile(
      leading: Icon(icon, color: AppColors.primary[60]),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppColors.primary : AppColors.black,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () => widget.onItemTapped(index),
    );
  }
}
