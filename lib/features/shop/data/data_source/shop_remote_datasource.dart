import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/shop/data/models/offers/get_all_offers_model.dart';
import 'package:tech_restore/features/shop/data/models/products/add_product_request.dart';
import 'package:tech_restore/features/shop/data/models/products/get_all_category_model.dart';
import 'package:tech_restore/features/shop/data/models/products/get_all_products_model.dart';
import 'package:tech_restore/features/shop/data/models/addresses/get_all_addresses_model.dart';
import 'package:tech_restore/features/shop/data/models/addresses/address_request.dart';
import 'package:tech_restore/features/shop/data/models/profile/shop_profile_model.dart';
import 'package:tech_restore/features/shop/data/models/profile/update_profile_request.dart';
import 'package:tech_restore/features/shop/data/models/orders/get_all_orders_model.dart';
import 'package:tech_restore/features/shop/data/models/orders/order_status_request.dart';
import '../models/offers/offer_request.dart';
import '../models/offers/offer_response.dart';
import '../models/chats/chat_session_model.dart' hide ChatMessageModel;
import '../models/chats/chat_message_model.dart';
import '../models/notifications/notification_model.dart';

import '../../../../core/api/client/api_client.dart';
import '../models/products/product_model.dart';

@lazySingleton
class ShopRemoteDataSource {
  final ApiClient _apiClient;

  ShopRemoteDataSource(this._apiClient);

  Future<GetAllOffersModel> getAllOffers({required int page}) async {
    return await _apiClient.getOffers(page);
  }

  Future<OfferResponse> addOffer(OfferRequest offer) async {
    return await _apiClient.addOffer(offer);
  }

  Future<void> deleteOffer(String offerId) async {
    await _apiClient.deleteOffer(offerId);
  }

  Future<OfferResponse> updateOffer(String offerId, OfferRequest offer) async {
    return await _apiClient.updateOffer(offer, offerId);
  }

  Future<GetAllCategoryModel> getAllCategory({required int page}) async {
    return await _apiClient.getAllCategory(page);
  }

  Future<GetAllProductsModel> getAllProducts({required int page}) async {
    return await _apiClient.getAllProducts(page);
  }

  Future<void> deleteProducts(String productId) async {
    await _apiClient.deleteProducts(productId);
  }

  Future<ProductModel> updateProducts(
    String productId,
    AddProductRequest product,
  ) async {
    return await _apiClient.updateProducts(product, productId);
  }

  Future<ProductModel> addProducts(AddProductRequest product) async {
    return await _apiClient.addProducts(product);
  }

  Future<GetAllProductsModel> searchInventory(String query, int page) async {
    return await _apiClient.searchInventory(query, page);
  }

  Future<int> lowStockInInventory() async {
    final result = await _apiClient.lowStockInInventory();
    return result.totalElements ?? 0;
  }

  Future<int> outOfStockInInventory() async {
    final result = await _apiClient.outOfStockInInventory();
    return result.totalElements ?? 0;
  }

  Future<int> totalItemsInInventory() async {
    return await _apiClient.totalItemsInInventory();
  }

  Future<double> totalInventoryValue() async {
    return await _apiClient.totalInventoryValue();
  }

  Future<List<ChatSessionModel>> getChatSessions() async {
    return await _apiClient.getChatSessions();
  }

  Future<List<ChatMessageModel>> getChatMessages(String sessionId) async {
    return await _apiClient.getChatMessages(sessionId);
  }

  // Messages are sent via WebSocket, not REST API

  Future<void> endChatSession(String sessionId) async {
    await _apiClient.endChatSession(sessionId);
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    return await _apiClient.getAllNotificationsShop();
  }

  Future<void> deleteNotification(String notificationId) async {
    await _apiClient.deleteNotificationShop(notificationId);
  }

  Future<GetAllAddressesModel> getAllAddresses({required int page}) async {
    return await _apiClient.getAllAddresses(page);
  }

  Future<void> addAddress(AddressRequest address) async {
    await _apiClient.addAddress(address);
  }

  Future<void> deleteAddress(String addressId) async {
    await _apiClient.deleteAddress(addressId);
  }

  Future<void> updateAddress(String addressId, AddressRequest address) async {
    await _apiClient.updateAddress(address, addressId);
  }

  Future<ShopProfileModel> getShopProfile(String shopId) async {
    return await _apiClient.getShopProfile(shopId);
  }

  Future<ShopProfileModel> updateShopProfile(String shopId, UpdateProfileRequest request) async {
    return await _apiClient.updateShopProfile(request, shopId);
  }

  Future<GetAllOrdersModel> getAllOrders({required int page}) async {
    return await _apiClient.getAllOrders(page);
  }

  Future<GetAllOrdersModel> getOrdersByStatus(String status, {required int page}) async {
    return await _apiClient.getOrdersByStatus(status, page);
  }

  Future<OrderContent> getOrderDetails(String orderId) async {
    return await _apiClient.getOrderDetails(orderId);
  }

  Future<void> acceptOrder(String orderId) async {
    await _apiClient.acceptOrder(orderId);
  }

  Future<void> rejectOrder(String orderId) async {
    await _apiClient.rejectOrder(orderId);
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    final request = OrderStatusRequest(status: status);
    await _apiClient.updateOrderStatus(orderId, request);
  }
}
