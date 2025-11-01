import '../../../data/models/profile_response.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileSuccess extends EditProfileState {
  final ProfileResponse profile;
  EditProfileSuccess(this.profile);
}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);
}
