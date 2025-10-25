import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import 'package:tech_restore/core/widgets/custom_text_field.dart';
import '../../../../core/config/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/toast_helper.dart';
import '../../../shop/shop_layout.dart';
import '../viewmodel/login_states.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<LoginViewModel>(),
      child: BlocConsumer<LoginViewModel, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ToastHelper.showCustomToast(
              context,
              text: local.loginSuccessMsg,
              isError: false,
            );
            final role = context.read<LoginViewModel>().getRole();
            if (role == "ROLE_GUEST") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.userHome,
                (route) => false,
              );
            } else if (role == "ROLE_ADMIN") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.adminDashboard,
                (route) => false,
              );
            } else {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.shopDashboard,
                (route) => false,
              );
            }
          } else if (state is LoginErrorState) {
            ToastHelper.showCustomToast(
              context,
              text: state.message,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginViewModel>();

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
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      controller: cubit.emailController,
                      hint: local.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      controller: cubit.passwordController,
                      hint: local.password,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                    const SizedBox(height: 17),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.forgetPassword);
                      },
                      child: Text(
                        local.forgetPassword,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        color: AppColors.primary,
                        text:
                            state is LoginLoadingState
                                ? local.loading
                                : local.login,
                        onPressed:
                            state is LoginLoadingState
                                ? null
                                : () {
                                  cubit.login();
                                },
                      ),
                    ),
                    const SizedBox(height: 14),

                    SizedBox(
                      width: double.infinity,
                      child: CustomElevatedButton(
                        color: AppColors.buttons,
                        text: local.withGoogle,
                        textColor: AppColors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopLayout(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          local.doHaveAnAccount,
                          style: const TextStyle(fontSize: 19),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: Text(
                            local.signUp,
                            style: const TextStyle(
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5,
                              decorationColor: AppColors.primary,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
