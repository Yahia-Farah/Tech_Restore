import '../../data/models/addresses/get_all_addresses_model.dart';

abstract class AddressesState {}

class AddressesInitial extends AddressesState {}

class AddressesLoading extends AddressesState {}

class AddressesLoaded extends AddressesState {
  final List<AddressContent> addresses;
  final bool lastPage;
  AddressesLoaded(this.addresses, {this.lastPage = false});
}

class AddressesError extends AddressesState {
  final String msg;
  AddressesError(this.msg);
}

class AddressesActionLoading extends AddressesState {}

class AddressesActionSuccess extends AddressesState {
  final String message;
  AddressesActionSuccess(this.message);
}

class AddressesActionError extends AddressesState {
  final String msg;
  AddressesActionError(this.msg);
}