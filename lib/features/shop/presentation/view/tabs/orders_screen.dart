import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/Widgets/custom_text_field.dart';
import 'dart:async';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/config/di.dart';
import '../../../data/repositories/shop_repository.dart';
import '../../../data/models/orders/get_all_orders_model.dart';
import '../../viewmodel/orders_cubit.dart';
import '../../viewmodel/orders_state.dart';
import '../widgets/order_details_dialog.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              OrdersCubit(getIt<ShopRepository>())
                ..getAllOrders(isRefresh: true),
      child: const OrdersScreenContent(),
    );
  }
}

class OrdersScreenContent extends StatefulWidget {
  const OrdersScreenContent({super.key});

  @override
  State<OrdersScreenContent> createState() => _OrdersScreenContentState();
}

class _OrdersScreenContentState extends State<OrdersScreenContent> {
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();
  List<OrderContent> _filteredOrders = [];
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  bool _isScrollingRight = true;
  bool _isUserScrolling = false;
  final ValueNotifier<int> _currentPageNotifier = ValueNotifier<int>(1);
  final int itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _startAutoScroll();
    // Initialize filtered orders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _filteredOrders = context.read<OrdersCubit>().orders;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
    _scrollTimer?.cancel();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    // Detect user interaction
    if (_scrollController.position.isScrollingNotifier.value) {
      if (!_isUserScrolling) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      }
    }
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();

    // Add a small delay before starting auto-scroll
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted || !_scrollController.hasClients) return;

      _scrollTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
        if (!_scrollController.hasClients || _isUserScrolling || !mounted)
          return;

        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        if (maxScroll <= 0) return; // No scrolling needed if content fits

        double targetScroll;
        const scrollSpeed = 1.0;

        if (_isScrollingRight) {
          if (currentScroll >= maxScroll) {
            _isScrollingRight = false;
            targetScroll = currentScroll - scrollSpeed;
          } else {
            targetScroll = currentScroll + scrollSpeed;
          }
        } else {
          if (currentScroll <= 0) {
            _isScrollingRight = true;
            targetScroll = currentScroll + scrollSpeed;
          } else {
            targetScroll = currentScroll - scrollSpeed;
          }
        }

        _scrollController.jumpTo(targetScroll.clamp(0.0, maxScroll));
      });
    });
  }

  void _onSearchChanged() {
    _filterOrders();
    _currentPageNotifier.value = 1; // Reset to first page when search changes
  }

  void _filterOrders() {
    final query = _searchController.text.toLowerCase();
    final allOrders = context.read<OrdersCubit>().orders;

    setState(() {
      if (query.isEmpty) {
        _filteredOrders = allOrders;
      } else {
        _filteredOrders =
            allOrders.where((order) {
              final customerName =
                  '${order.firstName ?? ''} ${order.lastName ?? ''}'
                      .toLowerCase();
              final orderId = order.id?.toLowerCase() ?? '';
              final products =
                  order.orderItems
                      ?.map((item) => item.productName?.toLowerCase() ?? '')
                      .join(' ') ??
                  '';
              final paymentMethod = order.paymentMethod?.toLowerCase() ?? '';

              return customerName.contains(query) ||
                  orderId.contains(query) ||
                  products.contains(query) ||
                  paymentMethod.contains(query);
            }).toList();
      }
    });
  }

  String _getCurrency(AppLocalizations local) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? 'ج.م' : 'EGP';
  }

  String _formatDate(String dateString, AppLocalizations local) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }

  int _getOrderCountByStatus(List<OrderContent> orders, String status) {
    return orders
        .where((o) => o.status?.toUpperCase() == status.toUpperCase())
        .length;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrderActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is OrderActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg), backgroundColor: Colors.red),
            );
          }

          // Update filtered orders when orders change
          if (state is OrdersLoaded) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _filterOrders();
            });
          }
        },
        child: ValueListenableBuilder<int>(
          valueListenable: _currentPageNotifier,
          builder: (context, currentPage, _) {
            // Get all orders from cubit
            final allOrders = context.read<OrdersCubit>().orders;

            // Apply search filter
            final filteredOrders =
                _filteredOrders.isNotEmpty || _searchController.text.isNotEmpty
                    ? _filteredOrders
                    : allOrders;

            // Pagination logic
            final totalPages =
                filteredOrders.isEmpty
                    ? 1
                    : (filteredOrders.length / itemsPerPage).ceil();
            final startIndex = (currentPage - 1) * itemsPerPage;
            final endIndex =
                (startIndex + itemsPerPage < filteredOrders.length)
                    ? startIndex + itemsPerPage
                    : filteredOrders.length;
            final currentOrders =
                filteredOrders.isEmpty
                    ? <OrderContent>[]
                    : filteredOrders.sublist(startIndex, endIndex);

            return RefreshIndicator(
              onRefresh: () async {
                _currentPageNotifier.value =
                    1; // Reset to first page on refresh
                if (_selectedFilter == 'all') {
                  await context.read<OrdersCubit>().getAllOrders(
                    isRefresh: true,
                  );
                } else {
                  await context.read<OrdersCubit>().getOrdersByStatus(
                    _selectedFilter,
                    isRefresh: true,
                  );
                }
              },
              color: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(local, isRTL),
                      const SizedBox(height: 24),
                      _buildSummaryCards(local, isRTL),
                      const SizedBox(height: 24),
                      _buildSearchAndFilter(local, isRTL),
                      const SizedBox(height: 24),
                      _buildOrdersTableWithPagination(
                        local,
                        isRTL,
                        currentOrders,
                        currentPage,
                        totalPages,
                        startIndex,
                        endIndex,
                        filteredOrders.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations local, bool isRTL) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            local.orders_title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            local.ordersSubtitle,
            style: const TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(AppLocalizations local, bool isRTL) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final orders = context.read<OrdersCubit>().orders;

        final pendingCount = _getOrderCountByStatus(orders, 'PENDING');
        final confirmedCount = _getOrderCountByStatus(orders, 'CONFIRMED');
        final shippedCount = _getOrderCountByStatus(orders, 'SHIPPED');
        final totalCount = orders.length;

        return GestureDetector(
          onPanStart: (_) {
            _isUserScrolling = true;
            _scrollTimer?.cancel();
          },
          onPanEnd: (_) {
            _isUserScrolling = false;
            Future.delayed(const Duration(seconds: 3), () {
              if (!_isUserScrolling &&
                  mounted &&
                  _scrollController.hasClients) {
                _startAutoScroll();
              }
            });
          },
          onPanCancel: () {
            _isUserScrolling = false;
            Future.delayed(const Duration(seconds: 3), () {
              if (!_isUserScrolling &&
                  mounted &&
                  _scrollController.hasClients) {
                _startAutoScroll();
              }
            });
          },
          onTap: () {
            _isUserScrolling = true;
            _scrollTimer?.cancel();
            Future.delayed(const Duration(seconds: 3), () {
              if (!_isUserScrolling &&
                  mounted &&
                  _scrollController.hasClients) {
                _startAutoScroll();
              }
            });
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Row(
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                _buildSummaryCard(
                  title: local.totalOrders,
                  value: totalCount.toString(),
                  color: const Color(0xFF4CAF50),
                  icon: Icons.shopping_bag,
                  isRTL: isRTL,
                ),
                const SizedBox(width: 18),
                _buildSummaryCard(
                  title: local.pending,
                  value: pendingCount.toString(),
                  color: Colors.orange,
                  icon: Icons.access_time,
                  isRTL: isRTL,
                ),
                const SizedBox(width: 18),
                _buildSummaryCard(
                  title: local.completed,
                  value: confirmedCount.toString(),
                  color: Colors.blue,
                  icon: Icons.check_circle,
                  isRTL: isRTL,
                ),
                const SizedBox(width: 18),
                _buildSummaryCard(
                  title: local.shipped,
                  value: shippedCount.toString(),
                  color: Colors.teal,
                  icon: Icons.local_shipping,
                  isRTL: isRTL,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
    required bool isRTL,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment:
            isRTL ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment:
                isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(AppLocalizations local, bool isRTL) {
    return Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CustomTextFormField(
              controller: _searchController,
              hint: local.searchOrders,
              onChanged: (value) => _onSearchChanged(),
            ),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 160,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: _selectedFilter,
              isExpanded: true,
              underline: const SizedBox(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              items: [
                DropdownMenuItem(value: 'all', child: Text(local.all)),
                DropdownMenuItem(value: 'PENDING', child: Text(local.pending)),
                DropdownMenuItem(
                  value: 'CONFIRMED',
                  child: Text(local.completed),
                ),
                DropdownMenuItem(
                  value: 'PROCESSING',
                  child: Text(local.processing),
                ),
                DropdownMenuItem(
                  value: 'FINISHPROCESSING',
                  child: Text(local.finish_processing),
                ),
                DropdownMenuItem(value: 'SHIPPED', child: Text(local.shipped)),
                DropdownMenuItem(
                  value: 'DELIVERED',
                  child: Text(local.delivered),
                ),
                DropdownMenuItem(
                  value: 'CANCELLED',
                  child: Text(local.cancelled),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });

                _currentPageNotifier.value =
                    1; // Reset to first page when filter changes

                if (value == 'all') {
                  context.read<OrdersCubit>().getAllOrders(isRefresh: true);
                } else {
                  context.read<OrdersCubit>().getOrdersByStatus(
                    value!,
                    isRefresh: true,
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersTableWithPagination(
    AppLocalizations local,
    bool isRTL,
    List<OrderContent> orders,
    int currentPage,
    int totalPages,
    int startIndex,
    int endIndex,
    int totalItems,
  ) {
    final currency = _getCurrency(local);

    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading &&
            context.read<OrdersCubit>().orders.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        } else if (state is OrdersError) {
          return Center(
            child: Column(
              children: [
                Text('Error: ${state.msg}'),
                ElevatedButton(
                  onPressed:
                      () => context.read<OrdersCubit>().getAllOrders(
                        isRefresh: true,
                      ),
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (orders.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Center(
              child: Text(
                _searchController.text.isNotEmpty
                    ? 'No orders found matching "${_searchController.text}"'
                    : 'No orders found',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
          );
        }

        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: WidgetStateProperty.all(Colors.grey[100]),
                  columns: [
                    DataColumn(label: Text(local.customer)),
                    DataColumn(label: Text(local.products)),
                    DataColumn(label: Text(local.quantity)),
                    DataColumn(label: Text(local.total)),
                    DataColumn(label: Text(local.paymentMethod)),
                    DataColumn(label: Text(local.orderDate)),
                    DataColumn(label: Text(local.status)),
                    DataColumn(label: Text(local.actions)),
                  ],
                  rows:
                      orders.map((order) {
                        final productNames =
                            order.orderItems
                                ?.map((item) => item.productName ?? 'Unknown')
                                .join(', ') ??
                            'No products';
                        final totalQuantity =
                            order.orderItems?.fold<int>(
                              0,
                              (sum, item) => sum + (item.quantity ?? 0),
                            ) ??
                            0;

                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                '${order.firstName ?? ''} ${order.lastName ?? ''}',
                              ),
                            ),
                            DataCell(
                              SizedBox(
                                width: 150,
                                child: Text(
                                  productNames,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(Text(totalQuantity.toString())),
                            DataCell(
                              Text(
                                '${order.totalPrice?.toStringAsFixed(2) ?? '0.00'} $currency',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataCell(Text(order.paymentMethod ?? 'N/A')),
                            DataCell(
                              Text(_formatDate(order.createdAt ?? '', local)),
                            ),
                            DataCell(
                              _buildClickableStatus(order, local, context),
                            ),
                            DataCell(
                              _buildActionButtons(order, local, isRTL, context),
                            ),
                          ],
                        );
                      }).toList(),
                ),
              ),
              // Pagination
              if (totalItems > 0)
                _buildPagination(
                  local,
                  isRTL,
                  currentPage,
                  totalPages,
                  startIndex,
                  endIndex,
                  totalItems,
                ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(
    OrderContent order,
    AppLocalizations local,
    bool isRTL,
    BuildContext context,
  ) {
    final canAcceptReject = context.read<OrdersCubit>().canAcceptReject(
      order.status ?? '',
    );

    List<Widget> buttons = [
      _buildActionButton(
        icon: Icons.info_outline,
        label: local.details,
        color: Colors.orange,
        onTap: () => _showOrderDetails(context, order.id ?? ''),
        isRTL: isRTL,
      ),
    ];

    if (canAcceptReject) {
      buttons.addAll([
        const SizedBox(width: 8),
        _buildActionButton(
          icon: Icons.check,
          label: local.accept,
          color: Colors.green,
          onTap: () => context.read<OrdersCubit>().acceptOrder(order.id ?? ''),
          isRTL: isRTL,
        ),
        const SizedBox(width: 8),
        _buildActionButton(
          icon: Icons.close,
          label: local.reject,
          color: Colors.red,
          onTap: () => context.read<OrdersCubit>().rejectOrder(order.id ?? ''),
          isRTL: isRTL,
        ),
      ]);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: isRTL ? buttons.reversed.toList() : buttons,
    );
  }

  void _showOrderDetails(BuildContext context, String orderId) {
    context.read<OrdersCubit>().getOrderDetails(orderId);
    showDialog(
      context: context,
      builder:
          (dialogContext) => BlocProvider.value(
            value: context.read<OrdersCubit>(),
            child: OrderDetailsDialog(orderId: orderId),
          ),
    );
  }

  String _getStatusText(String status, AppLocalizations local) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return local.pending;
      case 'CONFIRMED':
        return local.completed;
      case 'PROCESSING':
        return local.processing;
      case 'FINISHPROCESSING':
        return local.finish_processing;
      case 'SHIPPED':
        return local.shipped;
      case 'DELIVERED':
        return local.delivered;
      case 'CANCELLED':
        return local.cancelled;
      default:
        return status;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.blue;
      case 'PROCESSING':
        return Colors.purple;
      case 'FINISHPROCESSING':
        return Colors.indigo;
      case 'SHIPPED':
        return Colors.teal;
      case 'DELIVERED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildClickableStatus(
    OrderContent order,
    AppLocalizations local,
    BuildContext context,
  ) {
    final currentStatus = order.status ?? '';
    final nextStatus = _getNextStatus(currentStatus);
    final canProgress = nextStatus != null;
    final currentStatusColor = _getStatusColor(currentStatus);

    return PopupMenuButton<String>(
      onSelected: (String newStatus) {
        context.read<OrdersCubit>().updateOrderStatus(
          order.id ?? '',
          newStatus,
        );
      },
      enabled: canProgress,
      offset: const Offset(0, 45), // Show dropdown below the status
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      shadowColor: Colors.black.withValues(alpha: 0.15),
      splashRadius: 0,
      itemBuilder: (BuildContext context) {
        if (!canProgress) return [];

        final nextStatusColor = _getStatusColor(nextStatus);

        return [
          PopupMenuItem<String>(
            value: nextStatus,
            padding: const EdgeInsets.all(0),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: nextStatusColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: nextStatusColor.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: nextStatusColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: nextStatusColor.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Change to ${_getStatusText(nextStatus, local)}',
                      style: TextStyle(
                        color: nextStatusColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: nextStatusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: nextStatusColor,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: currentStatusColor.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(24),
          border:
              canProgress
                  ? Border.all(
                    color: currentStatusColor.withValues(alpha: 0.25),
                    width: 1.5,
                  )
                  : Border.all(
                    color: currentStatusColor.withValues(alpha: 0.12),
                    width: 1,
                  ),
          boxShadow:
              canProgress
                  ? [
                    BoxShadow(
                      color: currentStatusColor.withValues(alpha: 0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                  : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentStatusColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: currentStatusColor.withValues(alpha: 0.3),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _getStatusText(currentStatus, local),
              style: TextStyle(
                color: currentStatusColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
            if (canProgress) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: currentStatusColor.withValues(alpha: 0.8),
                size: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String? _getNextStatus(String currentStatus) {
    const statusSequence = [
      'PENDING',
      'CONFIRMED',
      'PROCESSING',
      'FINISHPROCESSING',
      'SHIPPED',
    ];
    final currentIndex = statusSequence.indexOf(currentStatus.toUpperCase());
    if (currentIndex >= 0 && currentIndex < statusSequence.length - 1) {
      return statusSequence[currentIndex + 1];
    }
    return null;
  }

  Widget _buildPagination(
    AppLocalizations local,
    bool isRTL,
    int currentPage,
    int totalPages,
    int startIndex,
    int endIndex,
    int totalItems,
  ) {
    final cubit = context.read<OrdersCubit>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} $totalItems ${local.orders}",
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed:
                    currentPage > 1
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
                    onPressed:
                        () => _currentPageNotifier.value = currentPage + 1,
                    child: Text('${currentPage + 1}'),
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed:
                    (currentPage < totalPages ||
                            (currentPage == totalPages && !cubit.lastPage))
                        ? () async {
                          if (currentPage < totalPages) {
                            _currentPageNotifier.value = currentPage + 1;
                          } else if (currentPage == totalPages &&
                              !cubit.lastPage) {
                            if (_selectedFilter == 'all') {
                              await cubit.getAllOrders();
                            } else {
                              await cubit.getOrdersByStatus(_selectedFilter);
                            }
                            _currentPageNotifier.value = currentPage + 1;
                          }
                        }
                        : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    required bool isRTL,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
