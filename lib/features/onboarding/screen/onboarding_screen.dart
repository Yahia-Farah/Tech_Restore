import 'package:flutter/material.dart';
import 'package:tech_restore/core/contants/app_images.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_elevated_button.dart';
import '../../auth/login/screen/login_screen.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = "start";
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Onboarding image
            Image.asset(AppImages.startScreen),
            const SizedBox(height: 30),

            /// Welcome text
            Text(
              local.welcome,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.secondary,
              ),
            ),

            /// Description text
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

            /// Start button
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(
                textColor: AppColors.secondary,
                color: AppColors.primary,
                text: local.start,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
