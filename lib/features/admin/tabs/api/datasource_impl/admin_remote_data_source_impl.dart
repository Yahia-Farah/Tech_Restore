import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:tech_restore/core/api/client/api_client.dart';
import '../../data/datasource/admin_remote_datasource.dart';
import '../../data/model/admin-states/admin_states_response.dart';
import '../../data/model/categories-model/categories_model_response.dart';
import '../../data/model/categories-model/categories_request.dart';
import '../../data/model/transaction-models/transaction_admin_response.dart';
import '../../manage-user/data/models/update_user_role_request.dart';

@LazySingleton(as: AdminRemoteDataSource)
class AdminRemoteDataSourceImpl implements AdminRemoteDataSource {
  final ApiClient _apiClient;

  AdminRemoteDataSourceImpl(this._apiClient);

  @override
  Future<AdminStatesResponse> getAdminStats() async {
    return await _apiClient.getAdminStats();
  }

  @override
  Future<String> updateUserRole(String userId, UpdateUserRoleRequest request) async {
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
  Future<String> updateCategory(String categoryId, CategoriesRequest request) async {
    return await _apiClient.updateCategoryAdmin(categoryId, request);
  }

  @override
  Future<String> deleteCategory(String categoryId) async {
    return await _apiClient.deleteCategoryAdmin(categoryId);
  }

  @override
  Future<TransactionAdminModelResponse> getAllTransactions(int page) async {
    log('🌐 [AdminRemoteDataSourceImpl] Calling API client getAllTransactionsAdmin with page: $page');
    try {
      final result = await _apiClient.getAllTransactionsAdmin(page);
      log('✅ [AdminRemoteDataSourceImpl] API client returned successfully. Total elements: ${result.totalElements}');
      return result;
    } catch (e, stackTrace) {
      log('❌ [AdminRemoteDataSourceImpl] API client call failed: $e', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}