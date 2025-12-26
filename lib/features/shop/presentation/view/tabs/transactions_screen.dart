import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../../core/Widgets/custom_text_field.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _searchQuery = "";
  int _currentPage = 1;
  final int _rowsPerPage = 5;
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  bool _isScrollingRight = true;
  bool _isUserScrolling = false;

  final List<Map<String, String>> _allTransactions = [
    {
      "date": "2023-05-15",
      "type": "Sale",
      "device": "iPhone 13 Pro",
      "shop": "Tech Haven",
      "payment": "VISA",
      "amount": "999.00 EGP",
      "status": "completed",
    },
    {
      "date": "2023-04-22",
      "type": "Repair",
      "device": "MacBook Pro Screen Replacement",
      "shop": "Device Medic",
      "payment": "Instapay",
      "amount": "299.00 EGP",
      "status": "completed",
    },
    {
      "date": "2023-03-10",
      "type": "Sale",
      "device": "AirPods Pro",
      "shop": "Audio World",
      "payment": "COD",
      "amount": "249.00 EGP",
      "status": "out_for_delivery",
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _startAutoScroll();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.isScrollingNotifier.value) {
      if (!_isUserScrolling) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      }
    } else {
      if (_isUserScrolling) {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 2), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      }
    }
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (!_scrollController.hasClients || _isUserScrolling) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;

      if (maxScroll <= 0) return;

      double targetScroll;
      const scrollSpeed = 0.8;

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

      _scrollController.animateTo(
        targetScroll.clamp(0.0, maxScroll),
        duration: const Duration(milliseconds: 20),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final filteredTransactions = _allTransactions.where((txn) {
      return txn["device"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          txn["shop"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          txn["type"]!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final totalPages = (filteredTransactions.length / _rowsPerPage).ceil();
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final endIndex = (_currentPage * _rowsPerPage).clamp(0, filteredTransactions.length);
    final currentPageItems = filteredTransactions.sublist(startIndex, endIndex);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
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
                  local.transactions_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  local.transactions_subtitle,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Summary Cards with Auto-Scroll
          GestureDetector(
            onPanStart: (_) {
              _isUserScrolling = true;
              _scrollTimer?.cancel();
            },
            onPanEnd: (_) {
              _isUserScrolling = false;
              Future.delayed(const Duration(seconds: 2), () {
                if (!_isUserScrolling && mounted && _scrollController.hasClients) {
                  _startAutoScroll();
                }
              });
            },
            onPanCancel: () {
              _isUserScrolling = false;
              Future.delayed(const Duration(seconds: 2), () {
                if (!_isUserScrolling && mounted && _scrollController.hasClients) {
                  _startAutoScroll();
                }
              });
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const ClampingScrollPhysics(),
              child: Row(
                children: [
                  _buildSummaryCard(
                    local.total_profits,
                    "2045.00 EGP",
                    Colors.blue,
                  ),
                  _buildSummaryCard(
                    "Repairs (27%)",
                    "548.00 EGP",
                    Colors.green,
                  ),
                  _buildSummaryCard(
                    "Sales (73%)",
                    "1497.00 EGP",
                    Colors.orange,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Search
          CustomTextFormField(
            hint: local.search_hint,
            onChanged: (val) {
              setState(() {
                _searchQuery = val;
                _currentPage = 1;
              });
            },
          ),
          const SizedBox(height: 20),

          // Table with Pagination
          Card(
            child: Column(
              children: [
                // Transactions Table
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text(local.date)),
                      DataColumn(label: Text(local.service_type)),
                      DataColumn(label: Text(local.device)),
                      DataColumn(label: Text(local.shop)),
                      DataColumn(label: Text(local.payment_method)),
                      DataColumn(label: Text(local.amount)),
                      DataColumn(label: Text(local.status)),
                    ],
                    rows: currentPageItems.map((txn) => _buildTransactionRow(
                      txn["date"]!,
                      txn["type"]!,
                      txn["device"]!,
                      txn["shop"]!,
                      txn["payment"]!,
                      txn["amount"]!,
                      txn["status"]!,
                      local,
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 12),

                // Footer + Pagination
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredTransactions.length} ${local.transactions}",
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: _currentPage > 1
                                ? () => setState(() => _currentPage--)
                                : null,
                          ),
                          for (int i = 1; i <= totalPages; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _currentPage == i
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  foregroundColor: _currentPage == i
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                onPressed: () => setState(() => _currentPage = i),
                                child: Text("$i"),
                              ),
                            ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: _currentPage < totalPages
                                ? () => setState(() => _currentPage++)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color color) {
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      width: 180,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: color, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isRTL ? MainAxisAlignment.end : MainAxisAlignment.start,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  DataRow _buildTransactionRow(
      String date,
      String type,
      String device,
      String shop,
      String payment,
      String amount,
      String status,
      AppLocalizations local,
      ) {
    Color statusColor;
    String statusLabel;

    switch (status) {
      case "completed":
        statusColor = Colors.green;
        statusLabel = local.completed;
        break;
      case "out_for_delivery":
        statusColor = Colors.orange;
        statusLabel = local.out_for_delivery;
        break;
      default:
        statusColor = Colors.red;
        statusLabel = local.failed;
    }

    return DataRow(
      cells: [
        DataCell(Text(date)),
        DataCell(Text(type)),
        DataCell(Text(device)),
        DataCell(Text(shop)),
        DataCell(Text(payment)),
        DataCell(Text(amount)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(statusLabel, style: TextStyle(color: statusColor)),
          ),
        ),
      ],
    );
  }
}