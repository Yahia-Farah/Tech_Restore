import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:tech_restore/core/extensions/extensions.dart';
import 'package:tech_restore/core/widgets/toast_helper.dart';
import '../../../../../../core/Widgets/custom_Elevated_Button.dart';
import '../../../../../../core/contants/app_icons.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../viewmodel/states/verify_code_states.dart';
import '../../viewmodel/verify_code_viewmodel.dart';
import '../widgets/verification_code_field.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String email;
  final bool isRegister;
  const EmailVerificationScreen({
    super.key,
    required this.email,
    required this.isRegister,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.email != "") {
      context.read<VerifyCodeCubit>().setEmail(widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:
          widget.isRegister
              ? AppBar()
              : AppBar(
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Image.asset(AppIcons.arrowBack,color: AppColors.primary,),
                ),
                title: Text(local.password),
              ),
      body: BlocConsumer<VerifyCodeCubit, VerifyCodeStates>(
        listener: (context, state) {
          if (state is VerifyCodeErrorStates) {
            ToastHelper.showCustomToast(
              context,
              isError: true,
              text: state.message,
            );
          }
        },
        builder: (context, state) {
          final cubit = context.watch<VerifyCodeCubit>();

          return SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    local.emailVerificationScreen,
                    style: TextStyle(
                      color: AppColors.primary[60],
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    local.emailVerificationScreenUnderMsg,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  const VerificationCodeField(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        local.codeReceiveMsgError,
                        style: const TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed:
                            cubit.isResendEnabled
                                ? () => cubit.resendCode()
                                : null,
                        child: Text(
                          cubit.isResendEnabled ? local.resend : local.resend,
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 17,
                            color:
                                cubit.isResendEnabled
                                    ? AppColors.primary
                                    : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  state is VerifyCodeLoadingStates
                      ? SizedBox(
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
                        text: local.nextButton,
                        onPressed:
                            cubit.enteredCode.length == 6
                                ? () {
                                  if (widget.isRegister) {
                                    cubit.registerVerify(context);
                                  } else {
                                    cubit.verify(context);
                                  }
                                }
                                : null,
                      ),
                ],
              ).setVerticalPadding(context, 0.04),
            ),
          );
        },
      ),
    );
  }
}
