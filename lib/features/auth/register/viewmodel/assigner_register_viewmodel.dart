import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/auth/register/viewmodel/register_states.dart';
import '../../domain/entites/assigner_entity.dart';
import '../../domain/usecases/assigner_signup_usecase.dart';

class AssignerRegisterCubit extends Cubit<RegisterState> {
  final AssignerSignupUseCase _signUpUseCase;

  AssignerRegisterCubit(this._signUpUseCase) : super(RegisterInitial());

  Future<void> signUp(AssignerEntity user) async {
    emit(RegisterLoading());
    try {
      final response = await _signUpUseCase.call(user);
      emit(RegisterSuccess(response.message));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
