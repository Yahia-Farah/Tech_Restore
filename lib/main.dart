import 'package:flutter/material.dart';
import 'package:tech_restore/ui/home/screen/home_screen.dart';
import 'package:tech_restore/ui/home/tabs/delivery/delivery-main.dart';
import 'package:tech_restore/ui/login/screen/login_screen.dart';
import 'package:tech_restore/ui/register/screen/register_screen.dart';
import 'package:tech_restore/ui/start_screen/screen/start_screen.dart' show StartScreen;

import 'core/color_manager.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: ColorManager.background,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          centerTitle: true,
      )
      ),
      routes: {
        StartScreen.routeName:(_)=>StartScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        HomeScreen.routename:(_)=>HomeScreen(),
        DeliveryDashboardScreen.routeName:(_)=>DeliveryDashboardScreen(),
      },
      initialRoute: StartScreen.routeName,
    );
  }
}
