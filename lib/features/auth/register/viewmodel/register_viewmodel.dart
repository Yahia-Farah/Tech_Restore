import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/auth/register/viewmodel/register_states.dart';

import '../../domain/entites/user_entity.dart';
import '../../domain/usecases/sign_up_use_case.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SignUpUseCase _signUpUseCase;

  RegisterCubit(this._signUpUseCase) : super(RegisterInitial());

  Future<void> signUp(UserEntity user) async {
    emit(RegisterLoading());
    try {
      final response = await _signUpUseCase.call(user);
      emit(RegisterSuccess(response.message ?? "Registered successfully"));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
