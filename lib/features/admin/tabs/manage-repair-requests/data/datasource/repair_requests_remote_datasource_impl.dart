import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api/client/api_client.dart';
import '../../../../../../core/errors/failure.dart';
import '../models/repair_request_model.dart';
import 'repair_requests_remote_datasource.dart';

@LazySingleton(as: RepairRequestsRemoteDataSource)
class RepairRequestsRemoteDataSourceImpl implements RepairRequestsRemoteDataSource {
  final ApiClient _apiClient;

  RepairRequestsRemoteDataSourceImpl(this._apiClient);

  String _extractApiMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      return data['error'] ??
          data['message'] ??
          ServerFailure.fromDio(e).errorMessage;
    }
    if (data is String) {
      try {
        final decoded = json.decode(data);
        if (decoded is Map) {
          return decoded['error'] ??
              decoded['message'] ??
              ServerFailure.fromDio(e).errorMessage;
        }
      } catch (_) {}
    }
    return ServerFailure.fromDio(e).errorMessage;
  }

  @override
  Future<RepairRequestModel> getAllRepairRequests(int page) async {
    try {
      return await _apiClient.getAdminRepairRequests(page);
    } on DioException catch (e) {
      throw Exception(_extractApiMessage(e));
    }
  }

  @override
  Future<RepairRequestModel> getRepairRequestsByStatus(String status, int page) async {
    try {
      return await _apiClient.getAdminRepairRequestsByStatus(status, page);
    } on DioException catch (e) {
      throw Exception(_extractApiMessage(e));
    }
  }
}
