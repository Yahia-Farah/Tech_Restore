import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/contants/secure_storage.dart';
import '../../../../core/errors/api_error_result.dart';
import '../../data/models/login_models/login_request_model.dart';
import '../../data/models/login_models/login_response_model.dart';
import '../../domain/usecases/login_usecase.dart';
import 'login_states.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(LoginInitialState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    emit(LoginLoadingState());

    try {
      final request = LoginRequestModel(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final LoginResponseModel response = await _loginUseCase(request);

      await SecureStorage.write(
        key: 'access_token',
        value: response.accessToken ?? "",
      );

      emit(LoginSuccessState(response));
    } on DioException catch (e) {
      final message = ApiErrorHandler.extractMessage(e);
      emit(LoginErrorState(message));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
