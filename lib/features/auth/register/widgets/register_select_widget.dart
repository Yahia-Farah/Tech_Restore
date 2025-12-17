import 'package:flutter/material.dart';
import 'package:tech_restore/core/contants/app_icons.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class RegisterSelectScreen extends StatelessWidget {
  final VoidCallback onDriverTap;
  final VoidCallback onUserTap;
  final VoidCallback onShopTap;
  final VoidCallback onAssignerTap;

  const RegisterSelectScreen({
    super.key,
    required this.onDriverTap,
    required this.onUserTap,
    required this.onShopTap,
    required this.onAssignerTap,
  });

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(AppIcons.arrowBack, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        scrolledUnderElevation: 0,
        title: Text(
          local.joinUsTitle,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 6),

              /// Subtitle
              Text(
                local.joinUsSubtitle,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),

              Expanded(
                child: Center(
                  child: GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(top: 80),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.95,
                        ),
                    children: [
                      _roleCard(
                        icon: Icons.local_shipping_outlined,
                        iconBg: Colors.green.shade100,
                        title: local.driverTitle,
                        subtitle: local.driverSubtitle,
                        onTap: onDriverTap,
                      ),
                      _roleCard(
                        icon: Icons.person_outline,
                        iconBg: Colors.red.shade100,
                        title: local.userTitle,
                        subtitle: local.userSubtitle,
                        onTap: onUserTap,
                      ),
                      _roleCard(
                        icon: Icons.store_mall_directory_outlined,
                        iconBg: Colors.teal.shade100,
                        title: local.shopTitle,
                        subtitle: local.shopSubtitle,
                        onTap: onShopTap,
                      ),
                      _roleCard(
                        icon: Icons.assignment_outlined,
                        iconBg: Colors.orange.shade100,
                        title: local.assignerTitle,
                        subtitle: local.assignerSubtitle,
                        onTap: onAssignerTap,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _roleCard({
    required IconData icon,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, size: 32, color: Colors.teal.shade600),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 15,
                height: 1.3,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
