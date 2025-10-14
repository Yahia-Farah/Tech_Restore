import 'package:flutter/material.dart';
import 'package:tech_restore/core/routes/route_names.dart';
import 'package:tech_restore/features/auth/login/screen/login_screen.dart';
import 'package:tech_restore/features/auth/register/screen/register_screen.dart';
import 'package:tech_restore/features/onboarding/screen/onboarding_screen.dart';

class Routes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.startScreen:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case AppRoutes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("No route defined")),
          ),
        );
    }
  }
}
