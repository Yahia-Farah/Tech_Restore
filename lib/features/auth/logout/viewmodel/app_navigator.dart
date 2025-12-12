import 'package:flutter/material.dart';
import 'package:tech_restore/core/routes/route_names.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static void logoutAndNavigate() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      AppRoutes.login,
          (route) => false,
    );
  }
}
