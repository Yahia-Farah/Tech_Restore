import 'package:injectable/injectable.dart';

import '../data_source/shop_remote_datasource.dart';
import '../models/offers/get_all_offers_model.dart';
import '../models/offers/offer_request.dart';
import '../models/offers/offer_response.dart';
import '../models/products/add_product_request.dart';
import '../models/products/get_all_products_model.dart';
import '../models/products/get_all_category_model.dart';
import '../models/products/product_model.dart';

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

}
