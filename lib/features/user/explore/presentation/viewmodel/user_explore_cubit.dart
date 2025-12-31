import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../data/repositories/user_explore_repository.dart';
import '../../data/models/shop_model.dart';
import '../../data/models/device_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/review_model.dart';
import '../../data/models/review_request_model.dart';
import 'user_explore_state.dart';

@injectable
class UserExploreCubit extends Cubit<UserExploreState> {
  final UserExploreRepository _repository;

  UserExploreCubit(this._repository) : super(UserExploreInitial());

  List<ShopModel> _shops = [];
  List<DeviceModel> _devices = [];
  List<CategoryModel> _categories = [];
  List<ReviewModel> _reviews = [];
  ShopModel? _currentShop;
  int _currentShopPage = 0;
  int _currentDevicePage = 0;
  int _currentReviewPage = 0;
  bool _hasMoreShops = true;
  bool _hasMoreDevices = true;
  bool _hasMoreReviews = true;

  // Getters
  List<ShopModel> get shops => _shops;
  List<DeviceModel> get devices => _devices;
  List<CategoryModel> get categories => _categories;
  List<ReviewModel> get reviews => _reviews;
  ShopModel? get currentShop => _currentShop;

  Future<void> getAllShops({bool refresh = false}) async {
    try {
      if (refresh) {
        _shops.clear();
        _currentShopPage = 0;
        _hasMoreShops = true;
        emit(UserExploreLoading());
      } else if (!_hasMoreShops) {
        return;
      } else if (_shops.isNotEmpty) {
        emit(UserExploreShopsLoadingMore(_shops));
      } else {
        emit(UserExploreLoading());
      }

      final response = await _repository.getAllShops(page: _currentShopPage);

      if (refresh) {
        _shops = response.content;
      } else {
        _shops.addAll(response.content);
      }

      _hasMoreShops = !response.last;
      _currentShopPage++;

      emit(
        UserExploreShopsLoaded(
          shops: _shops,
          hasMoreShops: _hasMoreShops,
          currentShopPage: _currentShopPage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> getAllDevices({bool refresh = false}) async {
    try {
      if (refresh) {
        _devices.clear();
        _currentDevicePage = 0;
        _hasMoreDevices = true;
        emit(UserExploreLoading());
      } else if (!_hasMoreDevices) {
        return;
      } else if (_devices.isNotEmpty) {
        emit(UserExploreDevicesLoadingMore(_devices));
      } else {
        emit(UserExploreLoading());
      }

      final response = await _repository.getAllDevices(
        page: _currentDevicePage,
      );

      // Filter out deleted devices
      final activeDevices =
          response.content.where((device) => !device.deleted).toList();

      if (refresh) {
        _devices = activeDevices;
      } else {
        _devices.addAll(activeDevices);
      }

      _hasMoreDevices = !response.last;
      _currentDevicePage++;

      emit(
        UserExploreDevicesLoaded(
          devices: _devices,
          hasMoreDevices: _hasMoreDevices,
          currentDevicePage: _currentDevicePage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> getCategories() async {
    try {
      if (_categories.isEmpty) {
        emit(UserExploreLoading());
      }

      final response = await _repository.getCategories();
      _categories = response.content;

      emit(UserExploreCategoriesLoaded(_categories));
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> getShopById(String shopId) async {
    try {
      emit(UserExploreLoading());
      final shop = await _repository.getShopById(shopId);
      _currentShop = shop;
      emit(UserExploreShopDetailsLoaded(shop));
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> getProductsByShop(String shopId, {bool refresh = false}) async {
    try {
      if (refresh) {
        _devices.clear();
        _currentDevicePage = 0;
        _hasMoreDevices = true;
        emit(UserExploreLoading());
      } else if (!_hasMoreDevices) {
        return;
      } else if (_devices.isNotEmpty) {
        emit(UserExploreDevicesLoadingMore(_devices));
      } else {
        emit(UserExploreLoading());
      }

      final response = await _repository.getProductsByShop(
        shopId,
        page: _currentDevicePage,
      );

      // Filter out deleted devices
      final activeDevices =
          response.content.where((device) => !device.deleted).toList();

      if (refresh) {
        _devices = activeDevices;
      } else {
        _devices.addAll(activeDevices);
      }

      _hasMoreDevices = !response.last;
      _currentDevicePage++;

      emit(
        UserExploreDevicesLoaded(
          devices: _devices,
          hasMoreDevices: _hasMoreDevices,
          currentDevicePage: _currentDevicePage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> getProductsByShopAndCategory(
    String shopId,
    String categoryId, {
    bool refresh = false,
  }) async {
    try {
      if (refresh) {
        _devices.clear();
        _currentDevicePage = 0;
        _hasMoreDevices = true;
        emit(UserExploreLoading());
      } else if (!_hasMoreDevices) {
        return;
      } else if (_devices.isNotEmpty) {
        emit(UserExploreDevicesLoadingMore(_devices));
      } else {
        emit(UserExploreLoading());
      }

      final response = await _repository.getProductsByShopAndCategory(
        shopId,
        categoryId,
        page: _currentDevicePage,
      );

      // Filter out deleted devices
      final activeDevices =
          response.content.where((device) => !device.deleted).toList();

      if (refresh) {
        _devices = activeDevices;
      } else {
        _devices.addAll(activeDevices);
      }

      _hasMoreDevices = !response.last;
      _currentDevicePage++;

      emit(
        UserExploreDevicesLoaded(
          devices: _devices,
          hasMoreDevices: _hasMoreDevices,
          currentDevicePage: _currentDevicePage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  void resetDevices() {
    _devices.clear();
    _currentDevicePage = 0;
    _hasMoreDevices = true;
  }

  void resetShops() {
    _shops.clear();
    _currentShopPage = 0;
    _hasMoreShops = true;
  }

  // Reviews methods
  Future<void> getShopReviews(String shopId, {bool refresh = false}) async {
    try {
      if (refresh) {
        _reviews.clear();
        _currentReviewPage = 0;
        _hasMoreReviews = true;
        emit(UserExploreLoading());
      } else if (!_hasMoreReviews) {
        return;
      } else if (_reviews.isNotEmpty) {
        emit(UserExploreReviewsLoadingMore(_reviews));
      } else {
        emit(UserExploreLoading());
      }

      final response = await _repository.getShopReviews(
        shopId,
        page: _currentReviewPage,
      );

      if (refresh) {
        _reviews = response.content;
      } else {
        _reviews.addAll(response.content);
      }

      _hasMoreReviews = !response.last;
      _currentReviewPage++;

      emit(
        UserExploreReviewsLoaded(
          reviews: _reviews,
          hasMoreReviews: _hasMoreReviews,
          currentReviewPage: _currentReviewPage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> addReview(String shopId, int rating, String comment) async {
    try {
      emit(UserExploreLoading());
      final request = ReviewRequestModel(rating: rating, comment: comment);
      final review = await _repository.addReview(shopId, request);

      // Add the new review to the beginning of the list
      _reviews.insert(0, review);

      emit(
        UserExploreReviewsLoaded(
          reviews: _reviews,
          hasMoreReviews: _hasMoreReviews,
          currentReviewPage: _currentReviewPage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> updateReview(String reviewId, int rating, String comment) async {
    try {
      emit(UserExploreLoading());
      final request = ReviewRequestModel(rating: rating, comment: comment);
      final updatedReview = await _repository.updateReview(reviewId, request);

      // Update the review in the list
      final index = _reviews.indexWhere((review) => review.id == reviewId);
      if (index != -1) {
        _reviews[index] = updatedReview;
      }

      emit(
        UserExploreReviewsLoaded(
          reviews: _reviews,
          hasMoreReviews: _hasMoreReviews,
          currentReviewPage: _currentReviewPage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  Future<void> deleteReview(String reviewId) async {
    try {
      emit(UserExploreLoading());
      await _repository.deleteReview(reviewId);

      // Remove the review from the list
      _reviews.removeWhere((review) => review.id == reviewId);

      emit(
        UserExploreReviewsLoaded(
          reviews: _reviews,
          hasMoreReviews: _hasMoreReviews,
          currentReviewPage: _currentReviewPage,
        ),
      );
    } catch (e) {
      emit(UserExploreError(e.toString()));
    }
  }

  void resetReviews() {
    _reviews.clear();
    _currentReviewPage = 0;
    _hasMoreReviews = true;
  }
}
