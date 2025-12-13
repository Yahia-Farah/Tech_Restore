import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/states/get_users_states.dart';
import '../../data/repo/get_user_repo_impl.dart';
import '../../../domain/usecases/update_user_role_usecase.dart';
import '../../../domain/usecases/deactivate_user_usecase.dart';
import '../../../domain/usecases/activate_user_usecase.dart';
import '../../data/models/update_user_role_request.dart';

@injectable
class GetUsersCubit extends Cubit<GetUsersState> {
  final GetUserRepository _repository;
  final UpdateUserRoleUseCase _updateUserRoleUseCase;
  final DeactivateUserUseCase _deactivateUserUseCase;
  final ActivateUserUseCase _activateUserUseCase;

  GetUsersCubit(
    this._repository,
    this._updateUserRoleUseCase,
    this._deactivateUserUseCase,
    this._activateUserUseCase,
  ) : super(GetUsersInitial());

  Future<void> getAllUsers() async {
    emit(GetUsersLoading());
    try {
      final users = await _repository.getUsers();
      emit(GetUsersLoaded(users));
    } catch (e) {
      emit(GetUsersError(e.toString()));
    }
  }

  Future<bool> updateUserRole(String userId, String role) async {
    try {
      final request = UpdateUserRoleRequest(role: role);
      await _updateUserRoleUseCase(userId, request);
      await getAllUsers(); // Refresh the list
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> toggleUserStatus(String userId, bool isActive) async {
    try {
      if (isActive) {
        await _deactivateUserUseCase(userId);
      } else {
        await _activateUserUseCase(userId);
      }
      await getAllUsers(); // Refresh the list
      return true;
    } catch (e) {
      return false;
    }
  }
}



