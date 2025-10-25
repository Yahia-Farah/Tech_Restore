import 'package:flutter/material.dart';
import 'package:tech_restore/core/contants/app_images.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_elevated_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Image.asset(AppImages.startScreen),
              const SizedBox(height: 30),
              Text(
                local.welcome,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
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
