import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/toast_helper.dart';
import '../../../user/home/screen/home_screen.dart';
import '../../domain/entites/user_entity.dart';
import '../viewmodel/register_states.dart';
import '../viewmodel/register_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

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
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: false,
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              } else if (state is RegisterError) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: true,
                );
              }
            },
            builder: (context, state) {
              return Column(
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
                  CustomTextFormField(
                    controller: _firstNameController,
                    hint: local.firstName,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _lastNameController,
                    hint: local.lastName,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _emailController,
                    hint: local.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _phoneController,
                    hint: local.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    controller: _passwordController,
                    hint: local.password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  state is RegisterLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      textColor: AppColors.secondary,
                      color: AppColors.buttons,
                      text: local.signup,
                      onPressed: () {
                        final user = UserEntity(
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          email: _emailController.text.trim(),
                          phone: _phoneController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        context.read<RegisterCubit>().signUp(user);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
