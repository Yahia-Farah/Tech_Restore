import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/api/client/api_client.dart';
import '../models/get_shops_response_model.dart';
import '../models/get_devices_response_model.dart';
import '../models/get_categories_response_model.dart';
import '../models/get_reviews_response_model.dart';
import '../models/shop_model.dart';
import '../models/review_model.dart';
import '../models/review_request_model.dart';

abstract class UserExploreRemoteDataSource {
  Future<GetShopsResponseModel> getAllShops({int page = 0});
  Future<GetDevicesResponseModel> getAllDevices({int page = 0});
  Future<GetCategoriesResponseModel> getCategories({int page = 0});
  Future<ShopModel> getShopById(String shopId);
  Future<GetDevicesResponseModel> getProductsByShop(
    String shopId, {
    int page = 0,
  });
  Future<GetDevicesResponseModel> getProductsByShopAndCategory(
    String shopId,
    String categoryId, {
    int page = 0,
  });

  // Reviews
  Future<GetReviewsResponseModel> getShopReviews(String shopId, {int page = 0});
  Future<ReviewModel> addReview(String shopId, ReviewRequestModel request);
  Future<ReviewModel> updateReview(String reviewId, ReviewRequestModel request);
  Future<void> deleteReview(String reviewId);
}

@Injectable(as: UserExploreRemoteDataSource)
class UserExploreRemoteDataSourceImpl implements UserExploreRemoteDataSource {
  final ApiClient _apiClient;

  UserExploreRemoteDataSourceImpl(this._apiClient);

  @override
  Future<GetShopsResponseModel> getAllShops({int page = 0}) async {
    try {
      final response = await _apiClient.getAllShopsUser(page);
      return GetShopsResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get shops: ${e.message}');
    }
  }

  @override
  Future<GetDevicesResponseModel> getAllDevices({int page = 0}) async {
    try {
      final response = await _apiClient.getAllDevices(page);
      return GetDevicesResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get devices: ${e.message}');
    }
  }

  @override
  Future<GetCategoriesResponseModel> getCategories({int page = 0}) async {
    try {
      final response = await _apiClient.getCategories(page);
      return GetCategoriesResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get categories: ${e.message}');
    }
  }

  @override
  Future<ShopModel> getShopById(String shopId) async {
    try {
      final response = await _apiClient.getShopById(shopId);
      return ShopModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get shop: ${e.message}');
    }
  }

  @override
  Future<GetDevicesResponseModel> getProductsByShop(
    String shopId, {
    int page = 0,
  }) async {
    try {
      final response = await _apiClient.getProductsByShop(shopId, page);
      return GetDevicesResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get shop products: ${e.message}');
    }
  }

  @override
  Future<GetDevicesResponseModel> getProductsByShopAndCategory(
    String shopId,
    String categoryId, {
    int page = 0,
  }) async {
    try {
      final response = await _apiClient.getProductsByShopAndCategory(
        shopId,
        categoryId,
        page,
      );
      return GetDevicesResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get filtered products: ${e.message}');
    }
  }

  @override
  Future<GetReviewsResponseModel> getShopReviews(
    String shopId, {
    int page = 0,
  }) async {
    try {
      final response = await _apiClient.getShopReviews(shopId, page);
      return GetReviewsResponseModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to get reviews: ${e.message}');
    }
  }

  @override
  Future<ReviewModel> addReview(
    String shopId,
    ReviewRequestModel request,
  ) async {
    try {
      final response = await _apiClient.addReview(shopId, request.toJson());
      return ReviewModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to add review: ${e.message}');
    }
  }

  @override
  Future<ReviewModel> updateReview(
    String reviewId,
    ReviewRequestModel request,
  ) async {
    try {
      final response = await _apiClient.updateReview(
        reviewId,
        request.toJson(),
      );
      return ReviewModel.fromJson(response);
    } on DioException catch (e) {
      throw Exception('Failed to update review: ${e.message}');
    }
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    try {
      await _apiClient.deleteReview(reviewId);
    } on DioException catch (e) {
      throw Exception('Failed to delete review: ${e.message}');
    }
  }
}
