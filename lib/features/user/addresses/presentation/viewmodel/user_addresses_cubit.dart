import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/user_addresses_repository.dart';
import '../../data/models/add_address_request_model.dart';
import '../../data/models/address_model.dart';
import 'user_addresses_state.dart';

@injectable
class UserAddressesCubit extends Cubit<UserAddressesState> {
  final UserAddressesRepository _repository;
  List<AddressModel> _addresses = [];

  UserAddressesCubit(this._repository) : super(UserAddressesInitial());

  List<AddressModel> get addresses => _addresses;

  void _sortAddresses() {
    _addresses.sort((a, b) {
      // Default address comes first
      if (a.isDefault && !b.isDefault) return -1;
      if (!a.isDefault && b.isDefault) return 1;
      // If both are default or both are not default, sort by creation date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });
  }

  Future<void> getUserAddresses() async {
    emit(UserAddressesLoading());
    try {
      final response = await _repository.getUserAddresses();
      _addresses = response.content;
      _sortAddresses();
      emit(UserAddressesLoaded(_addresses));
    } catch (e) {
      emit(UserAddressesError(e.toString()));
    }
  }

  Future<void> addAddress({
    required String state,
    required String city,
    required String street,
    required String building,
    String? notes,
    bool isDefault = false,
  }) async {
    emit(UserAddressAdding());
    try {
      final request = AddAddressRequestModel(
        state: state,
        city: city,
        street: street,
        building: building,
        notes: notes,
        isDefault: isDefault,
      );

      final newAddress = await _repository.addAddress(request);

      // If this is set as default, update other addresses to not be default
      if (isDefault) {
        _addresses =
            _addresses
                .map(
                  (address) => AddressModel(
                    id: address.id,
                    state: address.state,
                    city: address.city,
                    street: address.street,
                    building: address.building,
                    notes: address.notes,
                    userId: address.userId,
                    createdAt: address.createdAt,
                    latitude: address.latitude,
                    longitude: address.longitude,
                    isDefault:
                        false, // Remove default from all existing addresses
                  ),
                )
                .toList();
      }

      _addresses.add(newAddress);
      _sortAddresses(); // Sort to put default first
      emit(UserAddressAdded(newAddress));
      emit(UserAddressesLoaded(_addresses));
    } catch (e) {
      emit(UserAddressesError(e.toString()));
    }
  }

  Future<void> updateAddress({
    required String addressId,
    required String state,
    required String city,
    required String street,
    required String building,
    String? notes,
    bool isDefault = false,
  }) async {
    emit(UserAddressUpdating());
    try {
      final request = AddAddressRequestModel(
        state: state,
        city: city,
        street: street,
        building: building,
        notes: notes,
        isDefault: isDefault,
      );

      final updatedAddress = await _repository.updateAddress(
        addressId,
        request,
      );

      // If this is set as default, update other addresses to not be default
      if (isDefault) {
        _addresses =
            _addresses
                .map(
                  (address) =>
                      address.id == addressId
                          ? updatedAddress // Use the updated address
                          : AddressModel(
                            id: address.id,
                            state: address.state,
                            city: address.city,
                            street: address.street,
                            building: address.building,
                            notes: address.notes,
                            userId: address.userId,
                            createdAt: address.createdAt,
                            latitude: address.latitude,
                            longitude: address.longitude,
                            isDefault:
                                false, // Remove default from all other addresses
                          ),
                )
                .toList();
      } else {
        // Just update the specific address
        final index = _addresses.indexWhere(
          (address) => address.id == addressId,
        );
        if (index != -1) {
          _addresses[index] = updatedAddress;
        }
      }

      _sortAddresses(); // Sort to put default first
      emit(UserAddressUpdated(updatedAddress));
      emit(UserAddressesLoaded(_addresses));
    } catch (e) {
      emit(UserAddressesError(e.toString()));
    }
  }

  Future<void> deleteAddress(String addressId) async {
    emit(UserAddressDeleting());
    try {
      await _repository.deleteAddress(addressId);
      _addresses.removeWhere((address) => address.id == addressId);
      _sortAddresses(); // Sort after deletion
      emit(UserAddressDeleted(addressId));
      emit(UserAddressesLoaded(_addresses));
    } catch (e) {
      emit(UserAddressesError(e.toString()));
    }
  }

  void refreshAddresses() {
    getUserAddresses();
  }
}
