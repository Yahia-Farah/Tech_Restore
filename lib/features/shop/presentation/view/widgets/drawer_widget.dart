import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/contants/app_images.dart';
import '../../../../auth/logout/viewmodel/logout_viewmodel.dart';
import '../../../../auth/logout/views/logout_widget.dart';
import '../../../../../core/config/di.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  final Function(int) onItemTapped;

  const DrawerWidget({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Row(
                children: [
                  Image.asset(AppImages.startScreen, height: 100),
                  Text(
                    local.app_name,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(
                  icon: Icons.home_outlined,
                  title: local.dashboard,
                  index: 0,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.build_outlined,
                  title: local.repair,
                  index: 1,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.phone_android,
                  title: local.devices,
                  index: 2,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.shopping_bag_outlined,
                  title: local.orders,
                  index: 3,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.attach_money_outlined,
                  title: local.invoices,
                  index: 4,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.inventory_2_outlined,
                  title: local.inventory,
                  index: 5,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.wallet_rounded,
                  title: local.subs,
                  index: 6,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.local_offer_outlined,
                  title: local.offers,
                  index: 7,
                  context: context,
                ),
                _drawerItem(
                  icon: Icons.chat_bubble_outline,
                  title: local.support,
                  index: 8,
                  context: context,
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

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required int index,
    required BuildContext context,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(color: AppColors.primary, fontSize: 18),
      ),
      onTap: () {
        onItemTapped(index);
        Navigator.pop(context);
      },
    );
  }
}
