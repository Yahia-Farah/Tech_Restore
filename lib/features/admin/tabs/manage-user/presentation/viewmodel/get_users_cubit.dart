import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/admin/tabs/manage-user/presentation/viewmodel/states/get_users_states.dart';
import '../../data/repo/get_user_repo_impl.dart';

@injectable
class GetUsersCubit extends Cubit<GetUsersState> {
  final GetUserRepository _repository;

  GetUsersCubit(this._repository) : super(GetUsersInitial());

  Future<void> getAllUsers() async {
    emit(GetUsersLoading());
    try {
      final users = await _repository.getUsers();
      emit(GetUsersLoaded(users));
    } catch (e) {
      emit(GetUsersError(e.toString()));
    }
  }
}


