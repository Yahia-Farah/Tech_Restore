import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../../../../../core/errors/failure.dart';
import '../../data/datasource/admin_remote_datasource.dart';
import '../../data/model/admin-states/admin_states_response.dart';
import '../../data/model/categories-model/categories_model_response.dart';
import '../../data/model/categories-model/categories_request.dart';
import '../../data/model/transaction-models/transaction_admin_response.dart';
import '../../data/model/delivery-model/delivery_admin_response.dart';
import '../../data/model/delivery-model/content_delivery_admin.dart';
import '../../data/model/subscription-model/subscription_response.dart';
import '../../manage-offers/data/models/offer_page_model.dart';
import '../../manage-repair-requests/data/models/repair_request_model.dart';
import '../../manage-user/data/models/update_user_role_request.dart';

@LazySingleton(as: AdminRemoteDataSource)
class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final ApiClient _apiClient;


  AdminRemoteDataSourceImpl(this._apiClient);

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
  Future<AdminStatesResponse> getAdminStats() async {
    return await _apiClient.getAdminStats();
  }

  @override
  Future<String> updateUserRole(
    String userId,
    UpdateUserRoleRequest request,
  ) async {
    return await _apiClient.updateUserRole(userId, request);
  }

  @override
  Future<String> deactivateUser(String userId) async {
    return await _apiClient.deactivateUser(userId);
  }

  @override
  Future<String> activateUser(String userId) async {
    return await _apiClient.activateUser(userId);
  }

  @override
  Future<CategoriesResponse> getAllCategories(int page) async {
    return await _apiClient.getAllCategoriesAdmin(page);
  }

  @override
  Future<String> addCategory(CategoriesRequest request) async {
    return await _apiClient.addCategoryAdmin(request);
  }

  @override
  Future<String> updateCategory(
    String categoryId,
    CategoriesRequest request,
  ) async {
    return await _apiClient.updateCategoryAdmin(categoryId, request);
  }

  @override
  Future<String> deleteCategory(String categoryId) async {
    return await _apiClient.deleteCategoryAdmin(categoryId);
  }

  @override
  Future<TransactionAdminModelResponse> getAllTransactions(int page) async {
    log(
      '🌐 [AdminRemoteDataSourceImpl] Calling API client getAllTransactionsAdmin with page: $page',
    );
    try {
      final result = await _apiClient.getAllTransactionsAdmin(page);
      log(
        '✅ [AdminRemoteDataSourceImpl] API client returned successfully. Total elements: ${result.totalElements}',
      );
      return result;
    } catch (e, stackTrace) {
      log(
        '❌ [AdminRemoteDataSourceImpl] API client call failed: $e',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<DeliveryAdminResponse> getAllDeliveries(int page) async {
    return await _apiClient.getAllDeliveriesAdmin(page);
  }

  @override
  Future<ContentDeliveryAdmin> getDeliveryById(String deliveryId) async {
    return await _apiClient.getDeliveryAdminById(deliveryId);
  }

  @override
  Future<SubscriptionResponse> getAllSubscriptions(int page) async {
    return await _apiClient.getAllSubscriptions(page);
  }

  @override
  Future<SubscriptionResponse> getPendingCashSubscriptions(int page) async {
    return await _apiClient.getPendingCashSubscriptions(page);
  }

  @override
  Future<OfferPageModel> getAdminOffers(int page) async {
    return await _apiClient.getAdminOffers(page);
  }

  @override
  Future<RepairRequestModel> getAdminRepairRequests(int page) async {
    return await _apiClient.getAdminRepairRequests(page);
  }

  @override
  Future<RepairRequestModel> getAdminRepairRequestsByStatus(String status, int page) async {
    return await _apiClient.getAdminRepairRequestsByStatus(status, page);
  }
}
