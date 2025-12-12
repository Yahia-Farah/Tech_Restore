import '../../../data/models/user_model_response.dart';

abstract class GetUsersState {}

class GetUsersInitial extends GetUsersState {}

class GetUsersLoading extends GetUsersState {}

class GetUsersLoaded extends GetUsersState {
  final UserListResponse users;
  GetUsersLoaded(this.users);
}

class GetUsersError extends GetUsersState {
  final String message;
  GetUsersError(this.message);
}



