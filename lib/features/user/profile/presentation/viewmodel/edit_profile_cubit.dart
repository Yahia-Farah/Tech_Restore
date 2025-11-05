import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/models/edit_profile_request.dart';
import '../../data/repositories/profile_repo_impl.dart';
import '../viewmodel/states/edit_profile_states.dart';
import '../../data/models/profile_response.dart';

@injectable
class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepository _repository;

  EditProfileCubit(this._repository) : super(EditProfileInitial());

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void setInitialData(ProfileResponse user) {
    firstNameController.text = user.firstName ?? '';
    lastNameController.text = user.lastName ?? '';
    emailController.text = user.email ?? '';
    phoneController.text = user.phone ?? '';
  }

  Future<void> editProfile() async {
    emit(EditProfileLoading());
    try {
      final request = EditProfileRequest(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
      );
      final response = await _repository.editProfile(request);
      emit(EditProfileSuccess(response));
    } catch (e) {
      emit(EditProfileError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
