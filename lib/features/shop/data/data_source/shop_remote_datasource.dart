import 'package:injectable/injectable.dart';
import 'package:tech_restore/features/shop/data/models/offers/get_all_offers_model.dart';
import 'package:tech_restore/features/shop/data/models/products/add_product_request.dart';
import 'package:tech_restore/features/shop/data/models/products/get_all_category_model.dart';
import 'package:tech_restore/features/shop/data/models/products/get_all_products_model.dart';
import '../models/offers/offer_request.dart';
import '../models/offers/offer_response.dart';
import '../models/chats/chat_session_model.dart' hide ChatMessageModel;
import '../models/chats/chat_message_model.dart';

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

  Future<ProductModel> updateProducts(String productId,
      AddProductRequest product) async {
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
}
