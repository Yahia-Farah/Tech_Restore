import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entites/shop_entity.dart';
import '../../domain/usecases/shop_signup_usecase.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitial extends ShopRegisterState {}

class ShopRegisterLoading extends ShopRegisterState {}

class ShopRegisterSuccess extends ShopRegisterState {
  final String message;
  ShopRegisterSuccess(this.message);
}

class ShopRegisterError extends ShopRegisterState {
  final String message;
  ShopRegisterError(this.message);
}

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  final SignUpUseCase _signUpUseCase;
  ShopRegisterCubit(this._signUpUseCase) : super(ShopRegisterInitial());

  Future<void> signUp(ShopEntity entity) async {
    emit(ShopRegisterLoading());
    try {
      final result = await _signUpUseCase(
        ShopEntity(
          email: entity.email,
          password: entity.password,
          name: entity.name,
          description: entity.description,
          phone: entity.phone,
          shopType: entity.shopType.toUpperCase(),
          shopAddress: entity.shopAddress,
        ),
      );
      emit(ShopRegisterSuccess(result.message));
    } catch (e) {
      emit(ShopRegisterError(e.toString()));
    }
  }
}
