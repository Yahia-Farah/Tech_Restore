import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/data/models/shop_model.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/get_shops_cubit.dart';
import 'package:tech_restore/features/admin/tabs/manage-shops/presentation/viewmodel/states/get_shops_states.dart';

import '../../../../../../core/theme/app_colors.dart';
import '../../../../../auth/data/models/signup_shop_models/sign_up_shop_request_model.dart';

class AdminRepairScreen extends StatefulWidget {
  const AdminRepairScreen({super.key});

  @override
  State<AdminRepairScreen> createState() => _AdminRepairScreenState();
}

class _AdminRepairScreenState extends State<AdminRepairScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    context.read<GetShopsCubit>().getAllShops();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<GetShopsCubit, GetShopsState>(
        listener: (context, state) {
          if (state is GetShopsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: ${state.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GetShopsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetShopsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GetShopsCubit>().getAllShops();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is GetShopsLoaded) {
            final shops = state.shops.content ?? [];

            // Filter shops based on search query
            final filteredShops =
                shops.where((shop) {
                  final query = _searchQuery.toLowerCase();
                  final name = (shop.name ?? '').toLowerCase();
                  final email = (shop.email ?? '').toLowerCase();
                  final location =
                      _getLocationString(shop.shopAddress).toLowerCase();
                  return name.contains(query) ||
                      email.contains(query) ||
                      location.contains(query);
                }).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Stores Management",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Approve, suspend, and manage store registrations",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 20),

                  // Card wrapper
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Title + Search
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Stores",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    hintText: "Search stores...",
                                    prefixIcon: const Icon(Icons.search),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() => _searchQuery = val);
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // 👇 Scrollable table (only)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                // Table header
                                Container(
                                  color: Colors.grey[200],
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 8,
                                  ),
                                  child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 160,
                                        child: Text("Shop Name"),
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child: Text("Email"),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text("Location"),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text("Status"),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text("Rating"),
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Text("Join Date"),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: Text("Action"),
                                      ),
                                    ],
                                  ),
                                ),

                                // Filtered Shops list
                                if (filteredShops.isEmpty)
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text('No shops found'),
                                  )
                                else
                                  ...filteredShops.map(
                                    (shop) => _buildShopRow(shop),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _getLocationString(ShopAddress? address) {
    if (address == null) return 'N/A';
    final parts = <String>[];
    if (address.city.isNotEmpty) {
      parts.add(address.city);
    }
    if (address.state.isNotEmpty) {
      parts.add(address.state);
    }
    return parts.isEmpty ? 'N/A' : parts.join(', ');
  }

  Widget _buildShopRow(ShopModel shop) {
    final status = _getStatus(shop);
    final location = _getLocationString(shop.shopAddress);
    final joinDate =
        shop.createdAt != null ? shop.createdAt!.split('T')[0] : 'N/A';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          SizedBox(width: 160, child: Text(shop.name ?? 'N/A')),
          SizedBox(width: 160, child: Text(shop.email ?? 'N/A')),
          SizedBox(width: 200, child: Text(location)),
          SizedBox(width: 100, child: _buildStatusChip(status)),
          SizedBox(
            width: 100,
            child:
                shop.rating != null
                    ? Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(shop.rating!.toStringAsFixed(1)),
                      ],
                    )
                    : const Text("No ratings"),
          ),
          SizedBox(width: 120, child: Text(joinDate)),
          SizedBox(
            width: 100,
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  String _getStatus(ShopModel shop) {
    if (shop.activate == false) {
      return "Suspended";
    } else if (shop.verified == true) {
      return "Approved";
    } else {
      return "Pending";
    }
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;
    switch (status) {
      case "Approved":
        bg = Colors.green.withOpacity(0.2);
        text = Colors.green;
        break;
      case "Suspended":
        bg = Colors.red.withOpacity(0.2);
        text = Colors.red;
        break;
      case "Pending":
        bg = Colors.orange.withOpacity(0.2);
        text = Colors.orange;
        break;
      default:
        bg = Colors.grey.withOpacity(0.2);
        text = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(status, style: TextStyle(color: text, fontSize: 12)),
    );
  }
}
