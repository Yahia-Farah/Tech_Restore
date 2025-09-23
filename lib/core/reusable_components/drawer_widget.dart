import 'package:flutter/material.dart';
import '../assset_manager.dart';
import '../color_manager.dart';
import '../l10n/translation/app_localizations.dart';

class DrawerWidget extends StatelessWidget {
  final Function(int) onItemTapped;

  const DrawerWidget({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Center(
              child: Row(
                children: [
                  Image.asset(AsssetsManager.StartScreen, height: 100),
                  Text(
                    local.app_name,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined, color: ColorManager.primary),
            title: Text(local.dashboard,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.build_outlined, color: ColorManager.primary),
            title: Text(local.repair,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone_android, color: ColorManager.primary),
            title: Text(local.devices,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag_outlined, color: ColorManager.primary),
            title: Text(local.orders,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.attach_money_outlined, color: ColorManager.primary),
            title: Text(local.invoices,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(4);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2_outlined, color: ColorManager.primary),
            title: Text(local.inventory,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(5);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_offer_outlined, color: ColorManager.primary),
            title: Text(local.offers,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(6);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat_bubble_outline, color: ColorManager.primary),
            title: Text(local.support,
                style: TextStyle(color: ColorManager.primary, fontSize: 18)),
            onTap: () {
              onItemTapped(7);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
