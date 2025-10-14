import 'package:flutter/material.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../admin/admin_layout.dart';
import '../../../user/home/screen/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(local.signup),
        titleTextStyle: TextStyle(
          color: AppColors.secondary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  local.signUpQuote,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Text(
                  local.secSignUpQuote,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hint: local.name,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hint: local.username,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hint: local.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hint: local.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hint: local.password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Text(
                local.byContinuing,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.hint,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  textColor: AppColors.secondary,
                  color: AppColors.buttons,
                  text: local.signup,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  textColor: AppColors.secondary,
                  color: AppColors.buttons,
                  text: local.withGoogle,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminLayout()),
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
