import 'package:equatable/equatable.dart';
import '../../data/models/shop_model.dart';
import '../../data/models/device_model.dart';
import '../../data/models/category_model.dart';
import '../../data/models/review_model.dart';

abstract class UserExploreState extends Equatable {
  const UserExploreState();

  @override
  List<Object?> get props => [];
}

class UserExploreInitial extends UserExploreState {}

class UserExploreLoading extends UserExploreState {}

class UserExploreShopsLoaded extends UserExploreState {
  final List<ShopModel> shops;
  final bool hasMoreShops;
  final int currentShopPage;

  const UserExploreShopsLoaded({
    required this.shops,
    required this.hasMoreShops,
    required this.currentShopPage,
  });

  @override
  List<Object?> get props => [shops, hasMoreShops, currentShopPage];
}

class UserExploreDevicesLoaded extends UserExploreState {
  final List<DeviceModel> devices;
  final bool hasMoreDevices;
  final int currentDevicePage;

  const UserExploreDevicesLoaded({
    required this.devices,
    required this.hasMoreDevices,
    required this.currentDevicePage,
  });

  @override
  List<Object?> get props => [devices, hasMoreDevices, currentDevicePage];
}

class UserExploreCategoriesLoaded extends UserExploreState {
  final List<CategoryModel> categories;

  const UserExploreCategoriesLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class UserExploreShopDetailsLoaded extends UserExploreState {
  final ShopModel shop;

  const UserExploreShopDetailsLoaded(this.shop);

  @override
  List<Object?> get props => [shop];
}

class UserExploreError extends UserExploreState {
  final String message;

  const UserExploreError(this.message);

  @override
  List<Object?> get props => [message];
}

class UserExploreLoadingMore extends UserExploreState {}

class UserExploreShopsLoadingMore extends UserExploreState {
  final List<ShopModel> currentShops;

  const UserExploreShopsLoadingMore(this.currentShops);

  @override
  List<Object?> get props => [currentShops];
}

class UserExploreDevicesLoadingMore extends UserExploreState {
  final List<DeviceModel> currentDevices;

  const UserExploreDevicesLoadingMore(this.currentDevices);

  @override
  List<Object?> get props => [currentDevices];
}

class UserExploreReviewsLoaded extends UserExploreState {
  final List<ReviewModel> reviews;
  final bool hasMoreReviews;
  final int currentReviewPage;

  const UserExploreReviewsLoaded({
    required this.reviews,
    required this.hasMoreReviews,
    required this.currentReviewPage,
  });

  @override
  List<Object?> get props => [reviews, hasMoreReviews, currentReviewPage];
}

class UserExploreReviewsLoadingMore extends UserExploreState {
  final List<ReviewModel> currentReviews;

  const UserExploreReviewsLoadingMore(this.currentReviews);

  @override
  List<Object?> get props => [currentReviews];
}
