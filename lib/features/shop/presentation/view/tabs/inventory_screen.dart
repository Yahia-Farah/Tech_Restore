import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../data/models/products/product_model.dart';
import '../../../presentation/viewmodel/inventory_cubit.dart';
import '../../../presentation/viewmodel/inventory_state.dart';
import 'package:intl/intl.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ValueNotifier<String> _searchQueryNotifier = ValueNotifier<String>('');
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(1);
  final int itemsPerPage = 8;
  final formatter = NumberFormat("#,##0.###");

  @override
  void initState() {
    super.initState();
    final cubit = context.read<InventoryCubit>();
    cubit.searchInventory(isRefresh: true);
    cubit.loadInventoryStats();
    _searchController.addListener(() {
      final query = _searchController.text.trim();
      _searchQueryNotifier.value = query;
      _currentPageNotifier.value = 1;
      if (query.isEmpty || query.length >= 2) {
        cubit.searchInventory(query: query.isEmpty ? null : query, isRefresh: true);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQueryNotifier.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  String _getStatus(ProductModel product) {
    final stock = product.stock ?? 0;
    if (stock == 0) return "Out of Stock";
    if (stock <= 3) return "Low Stock";
    return "In Stock";
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "In Stock":
        return Colors.green;
      case "Low Stock":
        return Colors.orange;
      case "Out of Stock":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocConsumer<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is InventoryError || state is InventoryStatsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text((state as dynamic).msg)),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<InventoryCubit>();
        List<ProductModel> products = cubit.products;

        int totalItems = cubit.totalItems;
        int lowStockCount = cubit.lowStockCount;
        int outOfStockCount = cubit.outOfStockCount;
        double totalValue = cubit.totalValue;

        if (state is InventoryLoading || (state is InventoryInitial && products.isEmpty)) {
          return const Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            cubit.searchInventory(query: _searchController.text.trim().isEmpty ? null : _searchController.text.trim(), isRefresh: true);
            cubit.loadInventoryStats();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          local.inventory_title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          local.inventory_description,
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search
                  CustomTextFormField(
                    controller: _searchController,
                    hint: local.inventory_search,
                  ),
                  const SizedBox(height: 20),

                  // Summary Cards
                  BlocBuilder<InventoryCubit, InventoryState>(
                    builder: (context, state) {
                      if (state is InventoryStatsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildSummaryCard(
                              local.inventory_total_products,
                              "$totalItems",
                              Colors.blue,
                            ),
                            _buildSummaryCard(
                              local.inventory_low_stock,
                              "$lowStockCount",
                              Colors.orange,
                            ),
                            _buildSummaryCard(
                              "Out of stock",
                              "$outOfStockCount",
                              Colors.red,
                            ),
                            _buildSummaryCard(
                              local.inventory_total_price,
                              "${formatter.format(totalValue)} ${local.inventory_currency}",
                              Colors.black,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Table
                  ValueListenableBuilder<int>(
                    valueListenable: _currentPageNotifier,
                    builder: (context, currentPage, _) {
                      final totalPages = products.isEmpty
                          ? 1
                          : (products.length / itemsPerPage).ceil();
                      final startIndex = (currentPage - 1) * itemsPerPage;
                      final endIndex = (startIndex + itemsPerPage < products.length)
                          ? startIndex + itemsPerPage
                          : products.length;
                      final currentProducts = products.isEmpty
                          ? <ProductModel>[]
                          : products.sublist(startIndex, endIndex);

                      return Card(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                columns: [
                                  DataColumn(label: Text(local.inventory_product_name)),
                                  DataColumn(label: Text(local.inventory_category)),
                                  DataColumn(label: Text(local.inventory_price)),
                                  DataColumn(label: Text(local.inventory_quantity)),
                                  DataColumn(label: Text(local.inventory_status)),
                                ],
                                rows: currentProducts
                                    .map((product) => _buildInventoryRow(context, product))
                                    .toList(),
                              ),
                            ),

                            // Pagination
                            if (products.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${products.length} ${local.devices}",
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.chevron_left),
                                          onPressed: currentPage > 1
                                              ? () => _currentPageNotifier.value = currentPage - 1
                                              : null,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: null,
                                          child: Text('$currentPage'),
                                        ),
                                        if (currentPage < totalPages)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 4),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.grey.shade300,
                                                foregroundColor: Colors.black,
                                              ),
                                              onPressed: () => _currentPageNotifier.value = currentPage + 1,
                                              child: Text('${currentPage + 1}'),
                                            ),
                                          ),
                                        IconButton(
                                          icon: const Icon(Icons.chevron_right),
                                          onPressed: (currentPage < totalPages || (currentPage == totalPages && !cubit.lastPage))
                                              ? () async {
                                                  if (currentPage < totalPages) {
                                                    // Local pagination
                                                    _currentPageNotifier.value = currentPage + 1;
                                                  } else if (currentPage == totalPages && !cubit.lastPage) {
                                                    // Fetch next page from API
                                                    await cubit.searchInventory(
                                                      query: _searchController.text.trim().isEmpty ? null : _searchController.text.trim(),
                                                    );
                                                    // Move to next page after fetching
                                                    _currentPageNotifier.value = currentPage + 1;
                                                  }
                                                }
                                              : null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  DataRow _buildInventoryRow(BuildContext context, ProductModel product) {
    final status = _getStatus(product);
    final statusColor = _getStatusColor(status);

    return DataRow(
      cells: [
        DataCell(Text(product.name ?? '')),
        DataCell(Text(product.categoryName ?? '')),
        DataCell(Text("${product.price ?? 0}")),
        DataCell(Text("${product.stock ?? 0}")),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(color: statusColor)),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    return SizedBox(
      width: 200,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(color: Colors.grey)),
              Text(
                value,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
