

import 'package:flutter/material.dart';

import '../../../core/assset_manager.dart';

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
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.white),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AsssetsManager.StartScreen), // replace with your logo
                ),
                const SizedBox(width: 10),
                const Text(
                  "Tech & Restore",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),

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
    );
  }

  Widget _buildDrawerItem({
    required int index,
    required IconData icon,
    required String text,
  }) {
    final bool isSelected = index == selectedIndex;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Colors.blue : Colors.black54,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.blue : Colors.black87,
          fontSize: 16,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: Colors.blue.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onTap: () => onItemTapped(index),
    );
  }
}
