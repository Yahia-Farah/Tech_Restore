import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import 'package:tech_restore/core/widgets/custom_text_field.dart';
import '../../../../core/config/di.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../shop/layout.dart';
import '../../../user/home/screen/home_screen.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../register/screen/register_screen.dart';
import '../../register/viewmodel/register_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(local.login),
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
                  local.welcomeBack,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              CustomTextFormField(
                hint: local.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              /// Password Field
              CustomTextFormField(
                hint: local.password,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(height: 17),

              /// Forgot Password
              Text(
                local.forgetPassword,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.hint,
                ),
              ),
              const SizedBox(height: 20),

              /// Login Button
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  color: AppColors.primary,
                  text: local.login,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),

              /// Continue with Google
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  color: AppColors.buttons,
                  text: local.withGoogle,
                  textColor: AppColors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MainLayout()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              /// New User / Sign Up
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  textColor: AppColors.black,
                  color: AppColors.white,
                  text: local.newUser,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => RegisterCubit(getIt<SignUpUseCase>()),
                          child: const RegisterScreen(),
                        ),
                      ),
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
