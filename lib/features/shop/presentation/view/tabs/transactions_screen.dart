import 'package:flutter/material.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  String _searchQuery = "";
  String _selectedMonth = "month";
  int _currentPage = 1;
  final int _rowsPerPage = 5;

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
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    // 🔹 Filter search
    final filteredTransactions =
        _allTransactions.where((txn) {
          return txn["device"]!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              txn["shop"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              txn["type"]!.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    final totalPages = (filteredTransactions.length / _rowsPerPage).ceil();
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final endIndex = (_currentPage * _rowsPerPage).clamp(
      0,
      filteredTransactions.length,
    );
    final currentPageItems = filteredTransactions.sublist(startIndex, endIndex);

    final months = [
      {"key": "month", "label": local.month},
      {"key": "january", "label": local.january},
      {"key": "february", "label": local.february},
      {"key": "march", "label": local.march},
      {"key": "april", "label": local.april},
      {"key": "may", "label": local.may},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Header
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
                  local.transactions_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
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

          // 🔹 Search + Month Filter
          Row(
            children: [
              DropdownButton<String>(
                value: _selectedMonth,
                items:
                    months
                        .map(
                          (m) => DropdownMenuItem(
                            value: m["key"],
                            child: Text(m["label"]!),
                          ),
                        )
                        .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedMonth = val!;
                  });
                },
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: local.search_hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                      _currentPage = 1;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 🔹 Summary Cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildSummaryCard(
                  local.total_profits,
                  "2045.00 EGP",
                  Colors.blue,
                ),
                _buildSummaryCard(
                  local.repairs_percent(27),
                  "548.00 EGP",
                  Colors.green,
                ),
                _buildSummaryCard(
                  local.sales_percent(73),
                  "1497.00 EGP",
                  Colors.orange,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          Card(
            child: Column(
              children: [
                // 🔹 Transactions Table
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
                    rows:
                        currentPageItems
                            .map(
                              (txn) => _buildTransactionRow(
                                txn["date"]!,
                                txn["type"]!,
                                txn["device"]!,
                                txn["shop"]!,
                                txn["payment"]!,
                                txn["amount"]!,
                                txn["status"]!,
                                local,
                              ),
                            )
                            .toList(),
                  ),
                ),
                const SizedBox(height: 12),

                // 🔹 Footer + Pagination
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ("${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredTransactions.length} ${local.transactions}"),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed:
                                _currentPage > 1
                                    ? () => setState(() => _currentPage--)
                                    : null,
                          ),
                          for (int i = 1; i <= totalPages; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      _currentPage == i
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                  foregroundColor:
                                      _currentPage == i
                                          ? Colors.white
                                          : Colors.black,
                                ),
                                onPressed:
                                    () => setState(() => _currentPage = i),
                                child: Text("$i"),
                              ),
                            ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed:
                                _currentPage < totalPages
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                color: color,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
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
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(statusLabel, style: TextStyle(color: statusColor)),
          ),
        ),
      ],
    );
  }
}
