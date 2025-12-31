import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/config/di.dart';
import '../../../explore/presentation/viewmodel/user_explore_cubit.dart';
import '../../../explore/presentation/viewmodel/user_explore_state.dart';
import '../../../explore/data/models/shop_model.dart';
import '../../../explore/data/models/device_model.dart';
import '../../../explore/data/models/category_model.dart';

class Exploretab extends StatefulWidget {
  const Exploretab({super.key});

  @override
  State<Exploretab> createState() => _ExploretabState();
}

class _ExploretabState extends State<Exploretab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedCategory;
  String? _selectedCondition;
  late UserExploreCubit _cubit;
  final TextEditingController _shopsSearchController = TextEditingController();
  final TextEditingController _devicesSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _cubit = getIt<UserExploreCubit>();

    // Load initial data for the first tab (shops)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _cubit.getAllShops(refresh: true);
    });

    // Add listener to handle tab changes
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        if (_tabController.index == 1) {
          // Devices tab - load data if not already loaded
          if (_cubit.devices.isEmpty) {
            _cubit.getAllDevices(refresh: true);
          }
          if (_cubit.categories.isEmpty) {
            _cubit.getCategories();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _shopsSearchController.dispose();
    _devicesSearchController.dispose();
    super.dispose();
  }

  List<DeviceModel> _getFilteredDevices(List<DeviceModel> devices) {
    var filtered = devices;

    // Filter by search query
    final searchQuery = _devicesSearchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((device) {
        return device.name.toLowerCase().contains(searchQuery) ||
            device.description.toLowerCase().contains(searchQuery) ||
            device.categoryName.toLowerCase().contains(searchQuery);
      }).toList();
    }

    // Filter by category
    if (_selectedCategory != null && _selectedCategory != 'All') {
      filtered = filtered.where((device) {
        return device.categoryName == _selectedCategory;
      }).toList();
    }

    // Filter by condition
    if (_selectedCondition != null && _selectedCondition != 'All') {
      filtered = filtered.where((device) {
        return device.condition == _selectedCondition;
      }).toList();
    }

    return filtered;
  }

  List<ShopModel> _getFilteredShops(List<ShopModel> shops) {
    final searchQuery = _shopsSearchController.text.toLowerCase();
    if (searchQuery.isEmpty) return shops;

    return shops.where((shop) {
      return shop.name.toLowerCase().contains(searchQuery) ||
          shop.description.toLowerCase().contains(searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAF9),
        appBar: AppBar(
          title: const Text(
            "Explore",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            tabs: const [
              Tab(icon: Icon(Icons.store), text: "Shops"),
              Tab(icon: Icon(Icons.devices), text: "Devices"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [_buildShopsTab(), _buildDevicesTab()],
        ),
      ),
    );
  }

  Widget _buildShopsTab() {
    return BlocConsumer<UserExploreCubit, UserExploreState>(
      listener: (context, state) {
        if (state is UserExploreError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<UserExploreCubit>();

        if (state is UserExploreLoading && cubit.shops.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final shops = cubit.shops;
        final filteredShops = _getFilteredShops(shops);
        final isLoadingMore = state is UserExploreShopsLoadingMore;

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: Colors.white,
          onRefresh: () async {
            await cubit.getAllShops(refresh: true);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShopsSearchSection(),
                  const SizedBox(height: 20),
                  Text(
                    "Repair Shops Near You",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (filteredShops.isEmpty && state is! UserExploreLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          "No shops found",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredShops.length + (isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == filteredShops.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return _buildShopCard(filteredShops[index]);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDevicesTab() {
    return BlocConsumer<UserExploreCubit, UserExploreState>(
      listener: (context, state) {
        if (state is UserExploreError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<UserExploreCubit>();

        if (state is UserExploreLoading &&
            cubit.devices.isEmpty &&
            cubit.categories.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final devices = cubit.devices;
        final filteredDevices = _getFilteredDevices(devices);
        final categories = cubit.categories;
        final isLoadingMore = state is UserExploreDevicesLoadingMore;

        return RefreshIndicator(
          color: AppColors.primary,
          backgroundColor: Colors.white,
          onRefresh: () async {
            await Future.wait([
              cubit.getAllDevices(refresh: true),
              cubit.getCategories(),
            ]);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDevicesSearchSection(categories),
                  const SizedBox(height: 20),
                  Text(
                    "Available Devices",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (filteredDevices.isEmpty && state is! UserExploreLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          "No devices found",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredDevices.length + (isLoadingMore ? 2 : 0),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.84,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                      itemBuilder: (context, index) {
                        if (index >= filteredDevices.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return _buildDeviceCard(filteredDevices[index]);
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShopsSearchSection() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextField(
          controller: _shopsSearchController,
          onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: AppColors.primary),
            hintText: "Search shops...",
            hintStyle: TextStyle(color: Colors.grey[400]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green[100]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: const Color(0xFFF1F8E9),
          ),
        ),
      ),
    );
  }

  Widget _buildDevicesSearchSection(List<CategoryModel> categories) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: _devicesSearchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                hintText: "Search devices...",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
                filled: true,
                fillColor: const Color(0xFFF1F8E9),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Expanded(child: _buildCategoryFilterDropdown(categories)),
                const SizedBox(width: 12),
                Expanded(child: _buildConditionFilterDropdown()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilterDropdown(List<CategoryModel> categories) {
    // Use Set to remove duplicate category names
    List<String> categoryNames = ["All"];
    final uniqueNames = categories.map((cat) => cat.name).toSet().toList();
    categoryNames.addAll(uniqueNames);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text("Category", style: TextStyle(color: Colors.grey[600])),
          value: categoryNames.contains(_selectedCategory) ? _selectedCategory : null,
          isExpanded: true,
          items:
              categoryNames
                  .map(
                    (item) => DropdownMenuItem(value: item, child: Text(item)),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildConditionFilterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text("Condition", style: TextStyle(color: Colors.grey[600])),
          value: _selectedCondition,
          isExpanded: true,
          items:
              ["All", "NEW", "USED"]
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item == "NEW"
                            ? "New"
                            : item == "USED"
                            ? "Used"
                            : item,
                      ),
                    ),
                  )
                  .toList(),
          onChanged: (value) {
            setState(() {
              _selectedCondition = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildShopCard(ShopModel shop) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 80,
                height: 80,
                color: AppColors.primary.withValues(alpha: 0.1),
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
                      fontSize: 18,
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
                            color: Colors.green.withValues(alpha: 0.1),
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
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.visitShop,
                  arguments: shop.id,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: const Text(
                "Visit",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
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
          // Image section - Fixed height
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
          // Content section - Flexible height with proper constraints
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
                    child: ElevatedButton(
                      onPressed:
                          device.stock > 0
                              ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
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
                            device.stock > 0 ? AppColors.primary : Colors.grey,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
