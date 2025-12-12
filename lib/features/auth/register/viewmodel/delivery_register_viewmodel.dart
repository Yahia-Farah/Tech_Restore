import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/auth/register/viewmodel/register_states.dart';
import '../../domain/entites/delivery_entity.dart';
import '../../domain/usecases/delivery_signup_usecase.dart';

class DeliveryRegisterCubit extends Cubit<RegisterState> {
  final DeliverySignUpUseCase _signUpUseCase;

  DeliveryRegisterCubit(this._signUpUseCase) : super(RegisterInitial());

  Future<void> signUp(DeliveryEntity user) async {
    emit(RegisterLoading());
    try {
      final response = await _signUpUseCase.call(user);
      emit(RegisterSuccess(response.message));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
