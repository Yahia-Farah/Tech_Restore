import 'package:flutter/material.dart';
import '../../../core/l10n/translation/app_localizations.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final List<Map<String, dynamic>> devices = [
    {"name": "iPhone 13 Pro", "category": "Smartphones", "price": 999, "quantity": 15, "status": "In Stock"},
    {"name": "MacBook Pro 14”", "category": "Laptops", "price": 1999, "quantity": 8, "status": "In Stock"},
    {"name": "iPad Air", "category": "Tablets", "price": 699, "quantity": 2, "status": "Low Stock"},
    {"name": "Apple Watch", "category": "Wearables", "price": 399, "quantity": 0, "status": "Out of Stock"},
    {"name": "Samsung Galaxy S22", "category": "Smartphones", "price": 899, "quantity": 12, "status": "In Stock"},
  ];

  String searchQuery = "";
  int currentPage = 1;
  final int itemsPerPage = 4;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final filteredDevices = devices.where((device) => device["name"].toLowerCase().contains(searchQuery.toLowerCase())).toList();

    final totalPages = (filteredDevices.length / itemsPerPage).ceil();
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage < filteredDevices.length) ? startIndex + itemsPerPage : filteredDevices.length;

    final currentDevices = filteredDevices.sublist(startIndex, endIndex);

    final totalPrice = devices.fold<int>(0, (sum, d) => sum + (d["price"] as int) * (d["quantity"] as int));
    final lowStockCount = devices.where((d) => d["quantity"] <= 3 && d["quantity"] > 0).length;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(local.inventory_title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
                  const SizedBox(height: 8),
                  Text(local.inventory_description, style: const TextStyle(color: Colors.black54)),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search
            TextField(
              decoration: InputDecoration(
                hintText: local.inventory_search,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  currentPage = 1;
                });
              },
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade50, foregroundColor: Colors.blue),
                  child: Text(local.inventory_add_product),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade50, foregroundColor: Colors.purple),
                  child: Text(local.inventory_add_csv),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade50, foregroundColor: Colors.green),
                  child: Text(local.inventory_export_csv),
                ),
              ],
            ),
            const SizedBox(height: 50),

            // Table
            Card(
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
                        DataColumn(label: Text(local.inventory_action)),
                      ],
                      rows: currentDevices
                          .map((req) => _buildInventoryRow(
                        context,
                        req["name"]!,
                        req["category"]!,
                        req["price"]!,
                        req["quantity"]!,
                        req["status"]!,
                      ))
                          .toList(),
                    ),
                  ),

                  // Pagination
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredDevices.length} ${local.devices}",),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed: currentPage > 1 ? () => setState(() => currentPage--) : null,
                            ),
                            for (int i = 1; i <= totalPages; i++)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: currentPage == i ? Colors.blue : Colors.grey.shade300,
                                    foregroundColor: currentPage == i ? Colors.white : Colors.black,
                                  ),
                                  onPressed: () => setState(() => currentPage = i),
                                  child: Text("$i"),
                                ),
                              ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: currentPage < totalPages ? () => setState(() => currentPage++) : null,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),

            // Summary Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildSummaryCard(local.inventory_total_products, "${devices.length}", Colors.blue),
                  _buildSummaryCard(local.inventory_low_stock, "$lowStockCount", Colors.red),
                  _buildSummaryCard(local.inventory_total_price, "$totalPrice ${local.inventory_currency}", Colors.black),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  DataRow _buildInventoryRow(BuildContext context, String name, String category, int price, int quantity, String status) {
    final local = AppLocalizations.of(context)!;
    Color statusColor;
    switch (status) {
      case "In Stock":
        statusColor = Colors.green;
        break;
      case "Low Stock":
        statusColor = Colors.orange;
        break;
      case "Out of Stock":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(cells: [
      DataCell(Text(name)),
      DataCell(Text(category)),
      DataCell(Text("$price")),
      DataCell(Text("$quantity")),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
          child: Text(status, style: TextStyle(color: statusColor)),
        ),
      ),
      DataCell(Row(
        children: [
          Icon(Icons.edit, color: Colors.blue, semanticLabel: local.inventory_edit),
          const SizedBox(width: 8),
          Icon(Icons.delete, color: Colors.red, semanticLabel: local.inventory_delete),
        ],
      )),
    ]);
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
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: color)),
            ],
          ),
        ),
      ),
    );
  }
}
