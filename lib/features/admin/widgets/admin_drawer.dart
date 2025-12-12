import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/contants/app_images.dart';
import '../../../core/config/di.dart';
import '../../../core/l10n/translation/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../auth/logout/viewmodel/logout_viewmodel.dart';
import '../../auth/logout/views/logout_widget.dart';

class AdminDrawerWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const AdminDrawerWidget({
    super.key,
    required this.onItemTapped,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.white),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppImages.appIcon),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Tech & Restore",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  index: 0,
                  icon: Icons.dashboard_outlined,
                  text: "Dashboard",
                ),
                _buildDrawerItem(
                  index: 1,
                  icon: Icons.people_alt_outlined,
                  text: "Users",
                ),
                _buildDrawerItem(
                  index: 2,
                  icon: Icons.build_outlined,
                  text: "Repair Shops",
                ),
                _buildDrawerItem(
                  index: 3,
                  icon: Icons.attach_money_outlined,
                  text: "Transactions",
                ),
                _buildDrawerItem(
                  index: 4,
                  icon: Icons.star_border,
                  text: "Reviews",
                ),
                _buildDrawerItem(
                  index: 5,
                  icon: Icons.local_offer_outlined,
                  text: "Promotional Offers",
                ),
                _buildDrawerItem(
                  index: 6,
                  icon: Icons.support_agent_outlined,
                  text: "Support",
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

  Widget _buildDrawerItem({
    required int index,
    required IconData icon,
    required String text,
  }) {
    final bool isSelected = index == selectedIndex;

    return ListTile(
      leading: Icon(icon, color: isSelected ? AppColors.primary : AppColors.primary),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppColors.primary : Colors.black87,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.primary.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () => onItemTapped(index),
    );
  }
}
