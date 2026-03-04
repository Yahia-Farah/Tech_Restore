import '../../data/model/admin-states/admin_states_response.dart';
import '../../data/model/categories-model/categories_model_response.dart';
import '../../data/model/categories-model/categories_request.dart';
import '../../data/model/transaction-models/transaction_admin_response.dart';
import '../../data/model/delivery-model/delivery_admin_response.dart';
import '../../data/model/delivery-model/content_delivery_admin.dart';
import '../../data/model/subscription-model/subscription_response.dart';
import '../../manage-offers/data/models/offer_page_model.dart';
import '../../manage-user/data/models/update_user_role_request.dart';

abstract class AdminRepo {
  Future<AdminStatesResponse> getAdminStats();
  Future<String> updateUserRole(String userId, UpdateUserRoleRequest request);
  Future<String> deactivateUser(String userId);
  Future<String> activateUser(String userId);
  Future<CategoriesResponse> getAllCategories(int page);
  Future<String> addCategory(CategoriesRequest request);
  Future<String> updateCategory(String categoryId, CategoriesRequest request);
  Future<String> deleteCategory(String categoryId);
  Future<TransactionAdminModelResponse> getAllTransactions(int page);
  Future<DeliveryAdminResponse> getAllDeliveries(int page);
  Future<ContentDeliveryAdmin> getDeliveryById(String deliveryId);
  Future<SubscriptionResponse> getAllSubscriptions(int page);
  Future<SubscriptionResponse> getPendingCashSubscriptions(int page);
  Future<OfferPageModel> getAdminOffers(int page);
}
