import 'package:flutter/material.dart';
import 'package:tech_restore/core/contants/app_images.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../auth/domain/services/auth_services.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 80),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset(AppImages.startScreen),
              const SizedBox(height: 30),
              Text(
                local.welcome,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.secondary,
                ),
              ),

              Text(
                local.startQuote,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  textColor: AppColors.white,
                  color: AppColors.primary,
                  text: local.start,
                  onPressed: () async {
                    final initialRoute = await _getInitialRoute();
                    Navigator.pushReplacementNamed(context, initialRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> _getInitialRoute() async {
  final isLoggedIn = await AuthService.isUserAuthenticated();
  final role = await AuthService.getRole();
  if (isLoggedIn) {
    if (role == "ROLE_GUEST") {
      return AppRoutes.userHome;
    } else if (role == "ROLE_ADMIN") {
      return AppRoutes.adminDashboard;
    } else {
      return AppRoutes.shopDashboard;
    }
  } else {
    await AuthService.logout();
    return AppRoutes.login;
  }
}
