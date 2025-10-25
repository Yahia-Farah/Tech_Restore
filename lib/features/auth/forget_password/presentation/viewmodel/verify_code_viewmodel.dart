import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/auth/forget_password/presentation/viewmodel/states/verify_code_states.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../domain/usecases/verify_code_usecase.dart';
import '../../../domain/usecases/verify_email_usecase.dart';

@injectable
class VerifyCodeCubit extends Cubit<VerifyCodeStates> {
  final VerifyCodeUseCase _verifyCodeUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;

  String enteredCode = '';
  String? email;
  bool isResendEnabled = true;
  Timer? _resendTimer;

  VerifyCodeCubit(this._verifyCodeUseCase, this._verifyEmailUseCase)
    : super(VerifyCodeInitialStates());

  void setEmail(String emailAddress) {
    email = emailAddress;
  }

  void updateCode(String code) {
    enteredCode = code;
    emit(VerifyCodeInitialStates());
  }

  Future<void> resendCode() async {
    if (!isResendEnabled) return;

    isResendEnabled = false;
    emit(VerifyCodeLoadingStates());

    final result = await _verifyCodeUseCase(email!);
    if (result.isSuccess) {
      emit(VerifyCodeResendStates());
    } else {
      emit(VerifyCodeErrorStates(result.error ?? 'Unknown error'));
    }
    _startResendCooldown();
  }

  void _startResendCooldown() {
    _resendTimer?.cancel();
    _resendTimer = Timer(const Duration(seconds: 30), () {
      isResendEnabled = true;
      emit(VerifyCodeInitialStates());
    });
  }

  Future<void> verify(BuildContext context) async {
    if (enteredCode.length < 6) {
      emit(VerifyCodeErrorStates("Code must be 6 digits"));
      return;
    } else {
      emit(VerifyCodeSuccessStates());
      Navigator.pushNamed(
        context,
        AppRoutes.resetPassword,
        arguments: ResetPasswordData(email: email!, code: enteredCode),
      );
    }
  }

  Future<void> registerVerify(BuildContext context) async {
    if (enteredCode.length < 6) {
      emit(VerifyCodeErrorStates("Code must be 6 digits"));
      return;
    }
    final result = await _verifyEmailUseCase(email!, enteredCode);
    if (result.isSuccess) {
      emit(VerifyCodeSuccessStates());
      Navigator.pushNamed(
        context,
        AppRoutes.login,
        arguments: ResetPasswordData(email: email!, code: enteredCode),
      );
    } else {
      emit(VerifyCodeErrorStates(result.error ?? 'Unknown error'));
    }
  }
}

class ResetPasswordData {
  final String email;
  final String code;

  ResetPasswordData({required this.email, required this.code});
}

class VerifyEmailData {
  final String email;
  bool isRegister = false;

  VerifyEmailData({required this.email, required this.isRegister});
}
