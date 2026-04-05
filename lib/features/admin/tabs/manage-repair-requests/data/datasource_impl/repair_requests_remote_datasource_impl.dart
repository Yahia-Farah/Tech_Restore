import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../core/api/client/api_client.dart';
import '../../../../../../core/errors/failure.dart';
import '../datasource/repair_requests_remote_datasource.dart';
import '../models/repair_request_model.dart';

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
    log('🌐 [RepairRequestsRemoteDataSourceImpl] Calling API client getAdminRepairRequests with page: $page');
    try {
      final result = await _apiClient.getAdminRepairRequests(page);
      log('✅ [RepairRequestsRemoteDataSourceImpl] API client returned successfully. Total elements: ${result.totalElements}');
      return result;
    } on DioException catch (e) {
      log('❌ [RepairRequestsRemoteDataSourceImpl] DioException: ${e.message}');
      log('Response status: ${e.response?.statusCode}');
      log('Response data: ${e.response?.data}');
      throw Exception(_extractApiMessage(e));
    } catch (e, stackTrace) {
      log(
        '❌ [RepairRequestsRemoteDataSourceImpl] Unexpected error: $e',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to load repair requests. Please try again later.');
    }
  }

  @override
  Future<RepairRequestModel> getRepairRequestsByStatus(String status, int page) async {
    log('🌐 [RepairRequestsRemoteDataSourceImpl] Calling API client getAdminRepairRequestsByStatus with status: $status, page: $page');
    try {
      final result = await _apiClient.getAdminRepairRequestsByStatus(status, page);
      log('✅ [RepairRequestsRemoteDataSourceImpl] API client returned successfully. Total elements: ${result.totalElements}');
      return result;
    } on DioException catch (e) {
      log('❌ [RepairRequestsRemoteDataSourceImpl] DioException: ${e.message}');
      log('Response status: ${e.response?.statusCode}');
      log('Response data: ${e.response?.data}');
      throw Exception(_extractApiMessage(e));
    } catch (e, stackTrace) {
      log(
        '❌ [RepairRequestsRemoteDataSourceImpl] Unexpected error: $e',
        error: e,
        stackTrace: stackTrace,
      );
      throw Exception('Failed to load repair requests by status. Please try again later.');
    }
  }
}
