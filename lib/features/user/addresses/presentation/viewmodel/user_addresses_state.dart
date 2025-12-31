import 'package:equatable/equatable.dart';
import '../../data/models/address_model.dart';

abstract class UserAddressesState extends Equatable {
  const UserAddressesState();

  @override
  List<Object?> get props => [];
}

class UserAddressesInitial extends UserAddressesState {}

class UserAddressesLoading extends UserAddressesState {}

class UserAddressesLoaded extends UserAddressesState {
  final List<AddressModel> addresses;

  const UserAddressesLoaded(this.addresses);

  @override
  List<Object?> get props => [addresses];
}

class UserAddressesError extends UserAddressesState {
  final String message;

  const UserAddressesError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserAddressAdding extends UserAddressesState {}

class UserAddressAdded extends UserAddressesState {
  final AddressModel address;

  const UserAddressAdded(this.address);

  @override
  List<Object?> get props => [address];
}

class UserAddressUpdating extends UserAddressesState {}

class UserAddressUpdated extends UserAddressesState {
  final AddressModel address;

  const UserAddressUpdated(this.address);

  @override
  List<Object?> get props => [address];
}

class UserAddressDeleting extends UserAddressesState {}

class UserAddressDeleted extends UserAddressesState {
  final String addressId;

  const UserAddressDeleted(this.addressId);

  @override
  List<Object?> get props => [addressId];
}
