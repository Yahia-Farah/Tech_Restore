import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../models/get_addresses_response_model.dart';
import '../models/address_model.dart';
import '../models/add_address_request_model.dart';

abstract class UserAddressesRemoteDataSource {
  Future<GetAddressesResponseModel> getUserAddresses();
  Future<AddressModel> addAddress(AddAddressRequestModel request);
  Future<AddressModel> updateAddress(
    String addressId,
    AddAddressRequestModel request,
  );
  Future<void> deleteAddress(String addressId);
}

@Injectable(as: UserAddressesRemoteDataSource)
class UserAddressesRemoteDataSourceImpl
    implements UserAddressesRemoteDataSource {
  final ApiClient _apiClient;

  UserAddressesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<GetAddressesResponseModel> getUserAddresses() async {
    try {
      final response = await _apiClient.getUserAddresses();
      return GetAddressesResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get addresses: ${e.message}');
    }
  }

  @override
  Future<AddressModel> addAddress(AddAddressRequestModel request) async {
    try {
      final response = await _apiClient.addUserAddress(request.toJson());
      return AddressModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to add address: ${e.message}');
    }
  }

  @override
  Future<AddressModel> updateAddress(
    String addressId,
    AddAddressRequestModel request,
  ) async {
    try {
      final response = await _apiClient.updateUserAddress(
        addressId,
        request.toJson(),
      );
      return AddressModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to update address: ${e.message}');
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      await _apiClient.deleteUserAddress(addressId);
    } on DioException catch (e) {
      throw Exception('Failed to delete address: ${e.message}');
    }
  }
}
