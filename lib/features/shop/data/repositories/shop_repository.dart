import 'package:injectable/injectable.dart';

import '../data_source/shop_remote_datasource.dart';
import '../models/offers/get_all_offers_model.dart';
import '../models/offers/offer_request.dart';
import '../models/offers/offer_response.dart';
import '../models/products/add_product_request.dart';
import '../models/products/get_all_products_model.dart';
import '../models/products/get_all_category_model.dart';
import '../models/products/product_model.dart';
import '../models/addresses/get_all_addresses_model.dart';
import '../models/addresses/address_request.dart';
import '../models/profile/shop_profile_model.dart';
import '../models/profile/update_profile_request.dart';
import '../models/orders/get_all_orders_model.dart';
import '../models/transactions/financial_report_model.dart';
import '../models/chats/chat_session_model.dart' hide ChatMessageModel;
import '../models/chats/chat_message_model.dart';
import '../models/notifications/notification_model.dart';

@lazySingleton
class ShopRepository {
  final ShopRemoteDataSource _remoteDataSource;

  ShopRepository(this._remoteDataSource);

  Future<GetAllOffersModel> getAllOffers({required int page}) async {
    try {
      return await _remoteDataSource.getAllOffers(page: page);
    } catch (e) {
      throw Exception('Failed to get offers: ${e.toString()}');
    }
  }

  Future<OfferResponse> addOffer(OfferRequest offer) async {
    try {
      return await _remoteDataSource.addOffer(offer);
    } catch (e) {
      throw Exception('Failed to add offer: ${e.toString()}');
    }
  }

  Future<void> deleteOffer(String offerId) async {
    try {
      await _remoteDataSource.deleteOffer(offerId);
    } catch (e) {
      throw Exception('Failed to delete offer: ${e.toString()}');
    }
  }

  Future<OfferResponse> updateOffer(String offerId, OfferRequest offer) async {
    try {
      return await _remoteDataSource.updateOffer(offerId, offer);
    } catch (e) {
      throw Exception('Failed to update offer: ${e.toString()}');
    }
  }

  Future<GetAllProductsModel> getAllProducts({required int page}) async {
    try {
      return await _remoteDataSource.getAllProducts(page: page);
    } catch (e) {
      throw Exception('Failed to get products: ${e.toString()}');
    }
  }

  Future<GetAllCategoryModel> getAllCategory({required int page}) async {
    try {
      return await _remoteDataSource.getAllCategory(page: page);
    } catch (e) {
      throw Exception('Failed to get categories: ${e.toString()}');
    }
  }

  Future<ProductModel> addProducts(AddProductRequest request) async {
    try {
      return await _remoteDataSource.addProducts(request);
    } catch (e) {
      throw Exception('Failed to add product: ${e.toString()}');
    }
  }

  Future<ProductModel> updateProduct(
    String productId,
    AddProductRequest product,
  ) async {
    try {
      return await _remoteDataSource.updateProducts(productId, product);
    } catch (e) {
      throw Exception('Failed to update product: ${e.toString()}');
    }
  }

  Future<void> deleteProducts(String productId) async {
    try {
      return await _remoteDataSource.deleteProducts(productId);
    } catch (e) {
      throw Exception('Failed to delete product: ${e.toString()}');
    }
  }

  Future<GetAllProductsModel> searchInventory(String? query, int page) async {
    try {
      return await _remoteDataSource.searchInventory(query ?? '', page);
    } catch (e) {
      throw Exception('Failed to search inventory: ${e.toString()}');
    }
  }

  Future<int> lowStockInInventory() async {
    try {
      return await _remoteDataSource.lowStockInInventory();
    } catch (e) {
      throw Exception('Failed to get low stock in inventory: ${e.toString()}');
    }
  }

  Future<int> outOfStockInInventory() async {
    try {
      return await _remoteDataSource.outOfStockInInventory();
    } catch (e) {
      throw Exception(
        'Failed to get out of stock in inventory: ${e.toString()}',
      );
    }
  }

  Future<int> totalItemsInInventory() async {
    try {
      return await _remoteDataSource.totalItemsInInventory();
    } catch (e) {
      throw Exception(
        'Failed to get total items in inventory: ${e.toString()}',
      );
    }
  }

  Future<double> totalInventoryValue() async {
    try {
      return await _remoteDataSource.totalInventoryValue();
    } catch (e) {
      throw Exception('Failed to get total inventory value: ${e.toString()}');
    }
  }

  Future<List<ChatSessionModel>> getChatSessions() async {
    try {
      return await _remoteDataSource.getChatSessions();
    } catch (e) {
      throw Exception('Failed to get chat sessions: ${e.toString()}');
    }
  }

  Future<List<ChatMessageModel>> getChatMessages(String sessionId) async {
    try {
      return await _remoteDataSource.getChatMessages(sessionId);
    } catch (e) {
      throw Exception('Failed to get chat messages: ${e.toString()}');
    }
  }

  // Messages are sent via WebSocket, not REST API

  Future<void> endChatSession(String sessionId) async {
    try {
      await _remoteDataSource.endChatSession(sessionId);
    } catch (e) {
      throw Exception('Failed to end chat session: ${e.toString()}');
    }
  }

  Future<List<NotificationModel>> getAllNotifications() async {
    try {
      return await _remoteDataSource.getAllNotifications();
    } catch (e) {
      throw Exception('Failed to get notifications: ${e.toString()}');
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _remoteDataSource.deleteNotification(notificationId);
    } catch (e) {
      throw Exception('Failed to delete notification: ${e.toString()}');
    }
  }

  Future<GetAllAddressesModel> getAllAddresses({required int page}) async {
    try {
      return await _remoteDataSource.getAllAddresses(page: page);
    } catch (e) {
      throw Exception('Failed to get addresses: ${e.toString()}');
    }
  }

  Future<void> addAddress(AddressRequest address) async {
    try {
      await _remoteDataSource.addAddress(address);
    } catch (e) {
      throw Exception('Failed to add address: ${e.toString()}');
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      await _remoteDataSource.deleteAddress(addressId);
    } catch (e) {
      throw Exception('Failed to delete address: ${e.toString()}');
    }
  }

  Future<void> updateAddress(String addressId, AddressRequest address) async {
    try {
      await _remoteDataSource.updateAddress(addressId, address);
    } catch (e) {
      throw Exception('Failed to update address: ${e.toString()}');
    }
  }

  Future<ShopProfileModel> getShopProfile(String shopId) async {
    try {
      return await _remoteDataSource.getShopProfile(shopId);
    } catch (e) {
      throw Exception('Failed to get shop profile: ${e.toString()}');
    }
  }

  Future<ShopProfileModel> updateShopProfile(
    String shopId,
    UpdateProfileRequest request,
  ) async {
    try {
      return await _remoteDataSource.updateShopProfile(shopId, request);
    } catch (e) {
      throw Exception('Failed to update shop profile: ${e.toString()}');
    }
  }

  Future<GetAllOrdersModel> getAllOrders({required int page}) async {
    try {
      return await _remoteDataSource.getAllOrders(page: page);
    } catch (e) {
      throw Exception('Failed to get orders: ${e.toString()}');
    }
  }

  Future<GetAllOrdersModel> getOrdersByStatus(
    String status, {
    required int page,
  }) async {
    try {
      return await _remoteDataSource.getOrdersByStatus(status, page: page);
    } catch (e) {
      throw Exception('Failed to get orders by status: ${e.toString()}');
    }
  }

  Future<OrderContent> getOrderDetails(String orderId) async {
    try {
      return await _remoteDataSource.getOrderDetails(orderId);
    } catch (e) {
      throw Exception('Failed to get order details: ${e.toString()}');
    }
  }

  Future<void> acceptOrder(String orderId) async {
    try {
      await _remoteDataSource.acceptOrder(orderId);
    } catch (e) {
      throw Exception('Failed to accept order: ${e.toString()}');
    }
  }

  Future<void> rejectOrder(String orderId) async {
    try {
      await _remoteDataSource.rejectOrder(orderId);
    } catch (e) {
      throw Exception('Failed to reject order: ${e.toString()}');
    }
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    try {
      await _remoteDataSource.updateOrderStatus(orderId, status);
    } catch (e) {
      throw Exception('Failed to update order status: ${e.toString()}');
    }
  }

  Future<FinancialReportModel> getFinancialReport() async {
    try {
      return await _remoteDataSource.getFinancialReport();
    } catch (e) {
      throw Exception('Failed to get financial report: ${e.toString()}');
    }
  }
}
