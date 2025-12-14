import 'package:flutter/material.dart';
import 'package:tech_restore/core/Widgets/custom_text_field.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  String _selectedFilter = 'all';
  final TextEditingController _searchController = TextEditingController();

  // Sample orders data
  final List<Map<String, dynamic>> orders = [
    {
      'id': 1,
      'products': 'MacBook Pro 14"',
      'quantity': 2,
      'total': 3999.98,
      'paymentMethod': 'CASH',
      'orderDate': '2025/11/7',
      'status': 'pending',
    },
  ];

  int get _completedCount =>
      orders.where((o) => o['status'] == 'completed').length;
  int get _pendingCount => orders.where((o) => o['status'] == 'pending').length;
  int get _totalCount => orders.length;

  String _getCurrency(AppLocalizations local) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? 'ج.م' : 'EGP';
  }

  String _formatDate(String dateString, AppLocalizations local) {
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'ar') {
      return dateString.replaceAll('/', '/');
    }
    return dateString;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(local, isRTL),
              const SizedBox(height: 24),
              _buildSummaryCards(local, isRTL),
              const SizedBox(height: 24),
              _buildSearchAndFilter(local, isRTL),
              const SizedBox(height: 24),
              _buildOrdersTable(local, isRTL),
            ],
          ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        children: [
          _buildSummaryCard(
            title: local.completed,
            value: _completedCount.toString(),
            color: const Color(0xFF4CAF50),
            icon: Icons.check_circle,
            isRTL: isRTL,
          ),
          const SizedBox(width: 12),
          _buildSummaryCard(
            title: local.pending,
            value: _pendingCount.toString(),
            color: Colors.orange,
            icon: Icons.shopping_bag_outlined,
            isRTL: isRTL,
          ),
          const SizedBox(width: 12),
          _buildSummaryCard(
            title: local.totalOrders,
            value: _totalCount.toString(),
            color: const Color(0xFF4CAF50),
            icon: Icons.shopping_bag,
            isRTL: isRTL,
          ),
        ],
      ),
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
      padding: const EdgeInsets.all(16),
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
            )
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
                DropdownMenuItem(
                  value: 'completed',
                  child: Text(local.completed),
                ),
                DropdownMenuItem(value: 'pending', child: Text(local.pending)),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedFilter = value!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOrdersTable(AppLocalizations local, bool isRTL) {
    final currency = _getCurrency(local);
    final filteredOrders =
        _selectedFilter == 'all'
            ? orders
            : orders.where((o) => o['status'] == _selectedFilter).toList();

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.grey[100]),
          columns: [
            DataColumn(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('#'),
                  Icon(Icons.swap_vert, size: 16, color: Colors.grey[600]),
                ],
              ),
            ),
            DataColumn(label: Text(local.products)),
            DataColumn(label: Text(local.quantity)),
            DataColumn(label: Text(local.total)),
            DataColumn(label: Text(local.paymentMethod)),
            DataColumn(label: Text(local.orderDate)),
            DataColumn(label: Text(local.status)),
            DataColumn(label: Text(local.actions)),
          ],
          rows:
              filteredOrders.map((order) {
                return DataRow(
                  cells: [
                    DataCell(Text(order['id'].toString())),
                    DataCell(Text(order['products'])),
                    DataCell(Text(order['quantity'].toString())),
                    DataCell(
                      Text(
                        '${order['total']} $currency',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    DataCell(Text(order['paymentMethod'])),
                    DataCell(Text(_formatDate(order['orderDate'], local))),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          textDirection:
                              isRTL ? TextDirection.rtl : TextDirection.ltr,
                          children: [
                            Text(
                              order['status'] == 'pending'
                                  ? local.pending
                                  : local.completed,
                              style: TextStyle(
                                color: Colors.blue[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 16,
                              color: Colors.blue[700],
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        textDirection:
                            isRTL ? TextDirection.rtl : TextDirection.ltr,
                        children:
                            isRTL
                                ? [
                                  _buildActionButton(
                                    icon: Icons.close,
                                    label: local.reject,
                                    color: Colors.red,
                                    onTap: () {},
                                    isRTL: isRTL,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionButton(
                                    icon: Icons.check,
                                    label: local.accept,
                                    color: Colors.green,
                                    onTap: () {},
                                    isRTL: isRTL,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionButton(
                                    icon: Icons.info_outline,
                                    label: local.details,
                                    color: Colors.orange,
                                    onTap: () {},
                                    isRTL: isRTL,
                                  ),
                                ]
                                : [
                                  _buildActionButton(
                                    icon: Icons.info_outline,
                                    label: local.details,
                                    color: Colors.orange,
                                    onTap: () {},
                                    isRTL: isRTL,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionButton(
                                    icon: Icons.check,
                                    label: local.accept,
                                    color: Colors.green,
                                    onTap: () {},
                                    isRTL: isRTL,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildActionButton(
                                    icon: Icons.close,
                                    label: local.reject,
                                    color: Colors.red,
                                    onTap: () {},
                                    isRTL: isRTL,
                                  ),
                                ],
                      ),
                    ),
                  ],
                );
              }).toList(),
        ),
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
        color: color.withOpacity(0.1),
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
