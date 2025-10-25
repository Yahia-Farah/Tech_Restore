import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../tabs/account_tab/account_tab.dart';
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
  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), Exploretab(), Tracktab(), Accounttab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck_rounded),
            label: "Track",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Account",
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }
}
