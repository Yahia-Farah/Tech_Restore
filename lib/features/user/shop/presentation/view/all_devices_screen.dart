import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/config/di.dart';
import '../../../explore/presentation/viewmodel/user_explore_cubit.dart';
import '../../../explore/presentation/viewmodel/user_explore_state.dart';
import '../../../explore/data/models/device_model.dart';
import '../../../explore/data/models/category_model.dart';

class AllDevicesScreen extends StatefulWidget {
  final String shopId;

  const AllDevicesScreen({super.key, required this.shopId});

  @override
  State<AllDevicesScreen> createState() => _AllDevicesScreenState();
}

class _AllDevicesScreenState extends State<AllDevicesScreen> {
  String? _selectedCategory;
  String? _selectedCondition;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  List<DeviceModel> _getFilteredDevices(List<DeviceModel> devices) {
    var filtered = devices;

    // Filter by search query
    final searchQuery = _searchController.text.toLowerCase();
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

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Load more devices when reaching the bottom
      context.read<UserExploreCubit>().getProductsByShop(widget.shopId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<UserExploreCubit>()
                ..getProductsByShop(widget.shopId, refresh: true)
                ..getCategories(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F7FA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFF5F7FA),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: AppColors.primary),
          ),
          title: Text(
            "All Devices",
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
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
          },
          builder: (context, state) {
            if (state is UserExploreLoading &&
                context.read<UserExploreCubit>().devices.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            final devices = context.read<UserExploreCubit>().devices;
            final filteredDevices = _getFilteredDevices(devices);
            final categories = context.read<UserExploreCubit>().categories;
            final isLoadingMore = state is UserExploreDevicesLoadingMore;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchSection(categories),
                  const SizedBox(height: 20),
                  Text(
                    "All Devices (${filteredDevices.length})",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child:
                        filteredDevices.isEmpty && state is! UserExploreLoading
                            ? const Center(
                              child: Text(
                                "No devices found",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                            : GridView.builder(
                              controller: _scrollController,
                              itemCount:
                                  filteredDevices.length + (isLoadingMore ? 2 : 0),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.84,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                  ),
                              itemBuilder: (context, index) {
                                if (index >= filteredDevices.length) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return _buildDeviceCard(filteredDevices[index]);
                              },
                            ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchSection(List<CategoryModel> categories) {
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
          TextField(
            controller: _searchController,
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
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildCategoryFilterDropdown(categories)),
              const SizedBox(width: 12),
              Expanded(child: _buildConditionFilterDropdown()),
            ],
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
}
