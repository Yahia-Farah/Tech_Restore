import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tech_restore/core/extensions/extensions.dart';
import 'package:tech_restore/features/auth/forget_password/presentation/viewmodel/verify_code_viewmodel.dart';
import '../../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/extensions/validations.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/routes/route_names.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/widgets/toast_helper.dart';
import '../../viewmodel/forget_password_viewmodel.dart';
import '../../viewmodel/states/forget_password_states.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ForgetPasswordCubit>();
    cubit.emailController.addListener(() {
      cubit.validateEmailField();
    });
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    final cubit = context.watch<ForgetPasswordCubit>();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(AppIcons.arrowBack,color: AppColors.primary,),
        ),
        title: Text(
          local.password,
        ),
      ),
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        builder: (context, state) {
          return Form(
            key: _formState,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  local.forgetPassword,
                  style: TextStyle(
                    color: AppColors.primary[60],
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  local.forgetPasswordUnderText,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                CustomTextFormField(
                  controller: cubit.emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return local.requiredEmailErrorMessage;
                    }
                    if (!Validations.validateEmail(value)) {
                      return local.validationEmailErrorMessage;
                    }
                    return null;
                  },
                  label: local.emailLabel,
                  hint: local.emailHintText,
                ),
                const SizedBox(height: 50),
                state is ForgetPasswordLoadingState
                    ? const SizedBox(
                      height: 50,
                      width: 50,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineScalePulseOut,
                        colors: [AppColors.primary],
                        strokeWidth: 2,
                        backgroundColor: Colors.transparent,
                      ),
                    )
                    : CustomElevatedButton(
                      text: local.continueButton,
                      onPressed:
                          cubit.isFormValid
                              ? () {
                                if (_formState.currentState!.validate()) {
                                  cubit.sendResetCode();
                                }
                              }
                              : null,
                      color:
                          cubit.isFormValid ? AppColors.primary : Colors.grey,
                    ),
              ],
            ).setHorizontalAndVerticalPadding(context, 0.055, 0.05),
          );
        },
        listener: (context, state) {
          if (!mounted) return;

          if (state is ForgetPasswordSuccessState) {
            Navigator.pushNamed(
              context,
              arguments: VerifyEmailData(
                email: cubit.emailController.text,
                isRegister: false,
              ),
              AppRoutes.emailVerification,
            );
          } else if (state is ForgetPasswordErrorState) {
            ToastHelper.showCustomToast(
              context,
              text: state.message,
              isError: true,
            );
          }
        },
      ),
    );
  }
}
