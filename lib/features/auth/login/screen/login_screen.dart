import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import 'package:tech_restore/core/widgets/custom_text_field.dart';
import '../../../../core/config/di.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/toast_helper.dart';
import '../../domain/services/auth_services.dart';
import '../../register/widgets/register_select_widget.dart';
import '../viewmodel/login_states.dart';
import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => getIt<LoginViewModel>(),
      child: BlocConsumer<LoginViewModel, LoginStates>(
        listener: (context, state) async {
          if (state is LoginSuccessState) {
            ToastHelper.showCustomToast(
              context,
              text: local.loginSuccessMsg,
              isError: false,
            );
            final role = context.read<LoginViewModel>().getRole();
            await AuthService.saveRole(role);
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
            } else if (role == "ROLE_DELIVERY") {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.deliveryDashboard,
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
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                // Background Header Section
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF1a1a2e),
                        const Color(0xFF16213e),
                        AppColors.primary.withValues(alpha: 0.8),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: MediaQuery.of(context).size.height * 0.27,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),

                
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              local.login,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              local.welcomeBack,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 80),


                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(24, 40, 24, 16),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
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
                                Row(
                                  children: [
                                    Checkbox(
                                      activeColor: AppColors.primary,
                                      checkColor: AppColors.white,
                                      value: cubit.rememberMe,
                                      onChanged: (value) {
                                        cubit.toggleRememberMe(value ?? false);
                                        setState(() {});
                                      },
                                    ),
                                    Text(
                                      local.rememberMe,
                                      style: const TextStyle(
                                        color: AppColors.black,
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.forgetPassword,
                                        );
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
                                  ],
                                ),
                                const SizedBox(height: 20),

                                SizedBox(
                                  width: double.infinity,
                                  child: CustomElevatedButton(
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

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      local.doHaveAnAccount,
                                      style: const TextStyle(fontSize: 19),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (
                                                  context,
                                                ) => RegisterSelectScreen(
                                                  onDriverTap:
                                                      () => Navigator.pushNamed(
                                                        context,
                                                        AppRoutes
                                                            .deliveryRegister,
                                                      ),
                                                  onUserTap:
                                                      () => Navigator.pushNamed(
                                                        context,
                                                        AppRoutes.register,
                                                      ),
                                                  onShopTap:
                                                      () => Navigator.pushNamed(
                                                        context,
                                                        AppRoutes.shopRegister,
                                                      ),
                                                  onAssignerTap:
                                                      () => Navigator.pushNamed(
                                                        context,
                                                        AppRoutes
                                                            .assignerRegister,
                                                      ),
                                                ),
                                          ),
                                        );
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
