import 'package:injectable/injectable.dart';
import '../data_source/user_addresses_remote_datasource.dart';
import '../models/get_addresses_response_model.dart';
import '../models/address_model.dart';
import '../models/add_address_request_model.dart';

abstract class UserAddressesRepository {
  Future<GetAddressesResponseModel> getUserAddresses();
  Future<AddressModel> addAddress(AddAddressRequestModel request);
  Future<AddressModel> updateAddress(
    String addressId,
    AddAddressRequestModel request,
  );
  Future<void> deleteAddress(String addressId);
}

@Injectable(as: UserAddressesRepository)
class UserAddressesRepositoryImpl implements UserAddressesRepository {
  final UserAddressesRemoteDataSource _remoteDataSource;

  UserAddressesRepositoryImpl(this._remoteDataSource);

  @override
  Future<GetAddressesResponseModel> getUserAddresses() async {
    return await _remoteDataSource.getUserAddresses();
  }

  @override
  Future<AddressModel> addAddress(AddAddressRequestModel request) async {
    return await _remoteDataSource.addAddress(request);
  }

  @override
  Future<AddressModel> updateAddress(
    String addressId,
    AddAddressRequestModel request,
  ) async {
    return await _remoteDataSource.updateAddress(addressId, request);
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    return await _remoteDataSource.deleteAddress(addressId);
  }
}
