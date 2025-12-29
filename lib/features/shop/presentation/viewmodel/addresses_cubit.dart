import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/addresses/get_all_addresses_model.dart';
import '../../data/models/addresses/address_request.dart';
import '../../data/repositories/shop_repository.dart';
import 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final ShopRepository _repo;
  AddressesCubit(this._repo) : super(AddressesInitial());

  int currentApiPage = 0;
  int totalApiPages = 1;
  bool lastPage = false;
  List<AddressContent> addresses = [];

  Future<void> getAllAddresses({bool isRefresh = false}) async {
    if (isRefresh) {
      currentApiPage = 0;
      totalApiPages = 1;
      lastPage = false;
      addresses.clear();
      emit(AddressesLoading());
    }
    if (lastPage) return;
    emit(AddressesLoading());
    try {
      final result = await _repo.getAllAddresses(page: currentApiPage);
      lastPage = result.last ?? false;
      totalApiPages = result.totalPages ?? 1;
      currentApiPage = (result.number ?? currentApiPage) + 1; // next page
      addresses.addAll(result.content ?? []);
      emit(
        AddressesLoaded(
          List<AddressContent>.from(addresses),
          lastPage: lastPage,
        ),
      );
    } catch (e) {
      emit(AddressesError(e.toString()));
    }
  }

  Future<void> addAddress(AddressRequest req) async {
    emit(AddressesActionLoading());
    try {
      // If this address is being set as default, first unset all other defaults
      if (req.isDefault == true) {
        await _unsetAllDefaultAddresses();
      }
      await _repo.addAddress(req);
      emit(AddressesActionSuccess('Address added successfully'));
      getAllAddresses(isRefresh: true);
    } catch (e) {
      emit(AddressesActionError(e.toString()));
    }
  }

  Future<void> updateAddress(String addressId, AddressRequest req) async {
    emit(AddressesActionLoading());
    try {
      // If this address is being set as default, first unset all other defaults
      if (req.isDefault == true) {
        await _unsetAllDefaultAddresses(excludeId: addressId);
      }
      await _repo.updateAddress(addressId, req);
      emit(AddressesActionSuccess('Address updated successfully'));
      getAllAddresses(isRefresh: true);
    } catch (e) {
      emit(AddressesActionError(e.toString()));
    }
  }

  // Helper method to unset all default addresses
  Future<void> _unsetAllDefaultAddresses({String? excludeId}) async {
    for (final address in addresses) {
      if (address.isDefault == true && address.id != excludeId) {
        final updateRequest = AddressRequest(
          state: address.state ?? '',
          city: address.city ?? '',
          street: address.street ?? '',
          building: address.building,
          notes: address.notes,
          isDefault: false, // Unset as default
          latitude: address.latitude ?? 0.0,
          longitude: address.longitude ?? 0.0,
        );
        await _repo.updateAddress(address.id!, updateRequest);
      }
    }
  }

  Future<void> deleteAddress(String addressId) async {
    emit(AddressesActionLoading());
    try {
      await _repo.deleteAddress(addressId);
      emit(AddressesActionSuccess('Address deleted successfully'));
      getAllAddresses(isRefresh: true);
    } catch (e) {
      emit(AddressesActionError(e.toString()));
    }
  }
}
