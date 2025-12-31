import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/config/di.dart';
import '../../../../auth/domain/services/auth_services.dart';
import '../../../explore/data/models/review_model.dart';
import '../../../explore/presentation/viewmodel/user_explore_cubit.dart';
import '../../../explore/presentation/viewmodel/user_explore_state.dart';
import '../../../explore/data/models/shop_model.dart';
import '../../../explore/data/models/device_model.dart';

class VisitShopScreen extends StatelessWidget {
  final String shopId;

  const VisitShopScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserExploreCubit>()..getShopById(shopId),
      child: Builder(
        builder:
            (context) => Scaffold(
              backgroundColor: const Color(0xFFF5F7FA),
              appBar: AppBar(
                backgroundColor: const Color(0xFFF5F7FA),
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
                ),
                title: BlocBuilder<UserExploreCubit, UserExploreState>(
                  builder: (context, state) {
                    if (state is UserExploreShopDetailsLoaded) {
                      return Text(
                        state.shop.name,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    return Text(
                      "Shop Details",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
              body: BlocConsumer<UserExploreCubit, UserExploreState>(
                listener: (context, state) {
                  if (state is UserExploreError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is UserExploreShopDetailsLoaded) {
                    // Load shop products and reviews when shop details are loaded
                    context.read<UserExploreCubit>().getProductsByShop(
                      shopId,
                      refresh: true,
                    );
                    context.read<UserExploreCubit>().getShopReviews(
                      shopId,
                      refresh: true,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserExploreLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Try to get shop from current state or cubit
                  ShopModel? shop;
                  if (state is UserExploreShopDetailsLoaded) {
                    shop = state.shop;
                  } else {
                    shop = _getShopFromContext(context);
                  }

                  // If we have shop data, show appropriate content based on state
                  if (shop != null) {
                    if (state is UserExploreReviewsLoaded) {
                      final devices = context.read<UserExploreCubit>().devices;
                      return _buildShopContentWithDevicesAndReviews(
                        context,
                        shop,
                        devices,
                        state.reviews,
                      );
                    } else if (state is UserExploreDevicesLoaded) {
                      return _buildShopContentWithDevices(
                        context,
                        shop,
                        state.devices,
                      );
                    } else {
                      return _buildShopContent(context, shop);
                    }
                  }

                  return const Center(
                    child: Text(
                      "Unable to load shop details",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  final userId = await AuthService.getUserId();
                  if (!context.mounted) return;

                  if (userId != null) {
                    // Navigate to chat list screen first to show existing chats with this shop
                    Navigator.pushNamed(
                      context,
                      AppRoutes.chatList,
                      arguments: {'shopId': shopId, 'userId': userId},
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please login to start a chat"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                backgroundColor: AppColors.primary,
                child: const Icon(Icons.chat, color: Colors.white),
              ),
            ),
      ),
    );
  }

  ShopModel? _getShopFromContext(BuildContext context) {
    final cubit = context.read<UserExploreCubit>();
    return cubit.currentShop;
  }

  Widget _buildShopContent(BuildContext context, ShopModel shop) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShopInfoCard(shop),
            const SizedBox(height: 24),
            _buildLoadingDevicesSection(),
            const SizedBox(height: 24),
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingDevicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Available Devices",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        const Center(child: CircularProgressIndicator()),
      ],
    );
  }

  Widget _buildShopContentWithDevices(
    BuildContext context,
    ShopModel shop,
    List<DeviceModel> devices,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShopInfoCard(shop),
            const SizedBox(height: 24),
            _buildDevicesSection(devices),
            const SizedBox(height: 24),
            _buildReviewsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildShopContentWithDevicesAndReviews(
    BuildContext context,
    ShopModel shop,
    List<DeviceModel> devices,
    List<ReviewModel> reviews,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildShopInfoCard(shop),
            const SizedBox(height: 24),
            _buildDevicesSection(devices),
            const SizedBox(height: 24),
            _buildReviewsSection(reviews),
          ],
        ),
      ),
    );
  }

  Widget _buildShopInfoCard(ShopModel shop) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 80,
              height: 80,
              color: AppColors.primary.withOpacity(0.1),
              child: Icon(Icons.store, color: AppColors.primary, size: 40),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shop.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  shop.description,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    if (shop.rating != null) ...[
                      const Icon(
                        Icons.star,
                        color: Color(0xFFFFB300),
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        shop.rating!.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    if (shop.verified)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "Verified",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                if (shop.shopAddress != null) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.grey[500],
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          shop.shopAddress!.fullAddress,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevicesSection(List<DeviceModel> devices) {
    return Builder(
      builder:
          (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Available Devices",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.allDevices,
                        arguments: shopId,
                      );
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (devices.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      "No devices available",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: devices.take(5).length, // Show max 5 devices
                    itemBuilder: (context, index) {
                      return Container(
                        width: 160,
                        margin: const EdgeInsets.only(right: 12),
                        child: _buildDeviceCard(devices[index]),
                      );
                    },
                  ),
                ),
            ],
          ),
    );
  }

  Widget _buildReviewsSection([List<ReviewModel>? reviews]) {
    final reviewsToShow = reviews ?? [];

    return Builder(
      builder:
          (context) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Reviews",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.allReviews,
                        arguments: shopId,
                      );
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (reviewsToShow.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Text(
                      "No reviews yet",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: reviewsToShow.take(3).length, // Show max 3 reviews
                  itemBuilder: (context, index) {
                    return _buildReviewCard(reviewsToShow[index]);
                  },
                ),
            ],
          ),
    );
  }

  Widget _buildDeviceCard(DeviceModel device) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 110,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF1F8E9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child:
                device.imageUrl.isNotEmpty
                    ? Image.network(
                      device.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.devices,
                          color: AppColors.primary,
                          size: 40,
                        );
                      },
                    )
                    : Icon(Icons.devices, color: AppColors.primary, size: 40),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    device.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: AppColors.primary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    device.categoryName,
                    style: TextStyle(color: Colors.grey[600], fontSize: 11),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${device.price.toStringAsFixed(2)} EGP",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color:
                              device.condition == "NEW"
                                  ? const Color(0xFFE8F5E8)
                                  : const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          device.condition == "NEW" ? "New" : "Used",
                          style: TextStyle(
                            color:
                                device.condition == "NEW"
                                    ? const Color(0xFF2E7D32)
                                    : const Color(0xFFE65100),
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: Builder(
                      builder:
                          (context) => ElevatedButton(
                            onPressed:
                                device.stock > 0
                                    ? () {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            "${device.name} added to cart!",
                                          ),
                                          duration: const Duration(seconds: 2),
                                          action: SnackBarAction(
                                            label: "View Cart",
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRoutes.cart,
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                    : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  device.stock > 0
                                      ? AppColors.primary
                                      : Colors.grey,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                            ),
                            child: Text(
                              device.stock > 0 ? "Buy Now" : "Out of Stock",
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ReviewModel review) {
    return FutureBuilder<String?>(
      future: AuthService.getUserId(),
      builder: (context, snapshot) {
        final currentUserId = snapshot.data;
        final bool isMyReview =
            currentUserId != null && review.userId == currentUserId;

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 20,
                child: Text(
                  review.userId.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            isMyReview
                                ? "You"
                                : "User ${review.userId.substring(0, 8)}...",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Text(
                          _formatDate(review.createdAt),
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < review.rating
                              ? Icons.star
                              : Icons.star_border,
                          color: const Color(0xFFFFB300),
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      review.comment,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                    if (isMyReview) ...[
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              // Navigate to all reviews screen where they can edit
                              Navigator.pushNamed(
                                context,
                                AppRoutes.allReviews,
                                arguments: shopId,
                              );
                            },
                            icon: const Icon(Icons.edit, size: 14),
                            label: const Text(
                              "Edit",
                              style: TextStyle(fontSize: 12),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "Just now";
    }
  }
}
