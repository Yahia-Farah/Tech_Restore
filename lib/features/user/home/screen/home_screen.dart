import 'package:flutter/material.dart';
import '../../../../core/color_manager.dart';
import '../tabs/account_tab/AccountTab.dart';
import '../tabs/explore_tab/ExploreTab.dart';
import '../tabs/home_tab/HomeTab.dart';
import '../tabs/track_tab/TrackTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    Hometab(),
    Exploretab(),
    Tracktab(),
    Accounttab(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorManager.background,
          currentIndex: selectedIndex,
            onTap: (index){
            selectedIndex = index;
            setState(() {

            });
            },
            items: [
              BottomNavigationBarItem(
                  icon:Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.search),
                label: "Explore"

              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.fire_truck_rounded),
                label: "Track",

              ),
              BottomNavigationBarItem(
                  icon:Icon(Icons.account_circle_outlined),
                label: "Account"

              ),
            ]
        ),
      body: tabs[selectedIndex],
    );
  }
}
