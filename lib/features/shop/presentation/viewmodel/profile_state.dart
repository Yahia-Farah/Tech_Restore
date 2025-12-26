import '../../data/models/profile/shop_profile_model.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final ShopProfileModel profile;
  ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String msg;
  ProfileError(this.msg);
}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateSuccess extends ProfileState {
  final String message;
  final ShopProfileModel profile;
  ProfileUpdateSuccess(this.message, this.profile);
}

class ProfileUpdateError extends ProfileState {
  final String msg;
  ProfileUpdateError(this.msg);
}