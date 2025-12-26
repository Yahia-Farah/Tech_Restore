import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/auth/domain/services/auth_services.dart';
import '../../data/models/profile/update_profile_request.dart';
import '../../data/repositories/shop_repository.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ShopRepository _repo;
  ProfileCubit(this._repo) : super(ProfileInitial());

  Future<void> getShopProfile() async {
    emit(ProfileLoading());
    try {
      final userId = await AuthService.getUserId();
      if (userId == null || userId.isEmpty) {
        emit(ProfileError('User ID not found'));
        return;
      }
      
      final profile = await _repo.getShopProfile(userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateShopProfile({
    String? name,
    String? description,
    String? phone,
    String? password,
  }) async {
    emit(ProfileUpdateLoading());
    try {
      final userId = await AuthService.getUserId();
      if (userId == null || userId.isEmpty) {
        emit(ProfileUpdateError('User ID not found'));
        return;
      }

      final request = UpdateProfileRequest(
        name: name,
        description: description,
        phone: phone,
        password: password,
      );

      final updatedProfile = await _repo.updateShopProfile(userId, request);
      
      emit(ProfileUpdateSuccess('Profile updated successfully', updatedProfile));
      
    } catch (e) {
      emit(ProfileUpdateError(e.toString()));
    }
  }
}