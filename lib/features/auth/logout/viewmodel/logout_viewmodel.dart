import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/services/auth_services.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'logout_states.dart';

@injectable
class LogoutViewModel extends Cubit<LogoutStates> {
  final LogoutUseCase logoutUseCase;
  LogoutViewModel(this.logoutUseCase) : super(LogoutInitial());

  Future<void> logout() async {
    emit(LogoutLoading());

    try {
      final result = await logoutUseCase();
      await AuthService.logout();
      emit(LogoutSuccess(result));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await AuthService.logout();
        emit(LogoutSuccess('Logout successful'));
      } else {
        await AuthService.logout();
        emit(LogoutSuccess('Logout successful'));
      }
    } catch (e) {
      await AuthService.logout();
      emit(LogoutSuccess('Logout successful'));
    }
  }
}
