import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import 'package:tech_restore/features/auth/register/viewmodel/assigner_register_viewmodel.dart';
import '../../../../core/contants/app_icons.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/toast_helper.dart';
import '../../domain/entites/assigner_entity.dart';
import '../../forget_password/presentation/viewmodel/verify_code_viewmodel.dart';
import '../viewmodel/register_states.dart';

class AssignerRegisterScreen extends StatefulWidget {
  const AssignerRegisterScreen({super.key});

  @override
  State<AssignerRegisterScreen> createState() => _AssignerRegisterScreenState();
}

class _AssignerRegisterScreenState extends State<AssignerRegisterScreen> {
  final _firstNameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(AppIcons.arrowBack,color: AppColors.primary,),
          onPressed: () => Navigator.pop(context),
        ),
        scrolledUnderElevation: 0,
        title: Text(local.signup),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: BlocConsumer<AssignerRegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                ToastHelper.showCustomToast(
                  context,
                  text: state.message,
                  isError: false,
                );
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.emailVerification,
                  arguments: VerifyEmailData(
                    email: _emailController.text.trim(),
                    isRegister: true,
                  ),
                      (routes) => false,
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
                      local.driverSubtitle,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: AppColors.primary[80],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.person_2_outlined,color: AppColors.primary,),
                    controller: _firstNameController,
                    hint: local.firstName,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.person_search_outlined,color: AppColors.primary,),
                    controller: _departmentController,
                    hint: local.department,
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.email_outlined,color: AppColors.primary,),
                    controller: _emailController,
                    hint: local.email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.phone_outlined,color: AppColors.primary,),
                    controller: _phoneController,
                    hint: local.phone,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    prefixIcon: Icon(Icons.lock_outline,color: AppColors.primary,),
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
                      textColor: AppColors.white,
                      color: AppColors.primary,
                      text: local.signup,
                      onPressed: () {
                        final user = AssignerEntity(
                          firstName: _firstNameController.text.trim(),
                          department: _departmentController.text.trim(),
                          email: _emailController.text.trim(),
                          phone: "+2${_phoneController.text.trim()}",
                          password: _passwordController.text.trim(),
                        );
                        context.read<AssignerRegisterCubit>().signUp(user);
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
