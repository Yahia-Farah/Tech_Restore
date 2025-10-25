import '../../data/models/login_models/login_response_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final LoginResponseModel loginResponseModel;

  LoginSuccessState(this.loginResponseModel);
}

class LoginErrorState extends LoginStates {
  final String message;

  LoginErrorState(this.message);
}
