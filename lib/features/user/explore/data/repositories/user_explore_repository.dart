import 'package:injectable/injectable.dart';
import '../data_source/user_explore_remote_datasource.dart';
import '../models/get_shops_response_model.dart';
import '../models/get_devices_response_model.dart';
import '../models/get_categories_response_model.dart';
import '../models/get_reviews_response_model.dart';
import '../models/shop_model.dart';
import '../models/review_model.dart';
import '../models/review_request_model.dart';

abstract class UserExploreRepository {
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

@Injectable(as: UserExploreRepository)
class UserExploreRepositoryImpl implements UserExploreRepository {
  final UserExploreRemoteDataSource _remoteDataSource;

  UserExploreRepositoryImpl(this._remoteDataSource);

  @override
  Future<GetShopsResponseModel> getAllShops({int page = 0}) async {
    return await _remoteDataSource.getAllShops(page: page);
  }

  @override
  Future<GetDevicesResponseModel> getAllDevices({int page = 0}) async {
    return await _remoteDataSource.getAllDevices(page: page);
  }

  @override
  Future<GetCategoriesResponseModel> getCategories({int page = 0}) async {
    return await _remoteDataSource.getCategories(page: page);
  }

  @override
  Future<ShopModel> getShopById(String shopId) async {
    return await _remoteDataSource.getShopById(shopId);
  }

  @override
  Future<GetDevicesResponseModel> getProductsByShop(
    String shopId, {
    int page = 0,
  }) async {
    return await _remoteDataSource.getProductsByShop(shopId, page: page);
  }

  @override
  Future<GetDevicesResponseModel> getProductsByShopAndCategory(
    String shopId,
    String categoryId, {
    int page = 0,
  }) async {
    return await _remoteDataSource.getProductsByShopAndCategory(
      shopId,
      categoryId,
      page: page,
    );
  }

  @override
  Future<GetReviewsResponseModel> getShopReviews(
    String shopId, {
    int page = 0,
  }) async {
    return await _remoteDataSource.getShopReviews(shopId, page: page);
  }

  @override
  Future<ReviewModel> addReview(
    String shopId,
    ReviewRequestModel request,
  ) async {
    return await _remoteDataSource.addReview(shopId, request);
  }

  @override
  Future<ReviewModel> updateReview(
    String reviewId,
    ReviewRequestModel request,
  ) async {
    return await _remoteDataSource.updateReview(reviewId, request);
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    return await _remoteDataSource.deleteReview(reviewId);
  }
}
