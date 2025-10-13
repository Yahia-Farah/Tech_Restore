import 'package:flutter/material.dart';
import '../widgets/admin_drawer.dart';

class AdminTransactionsScreen extends StatefulWidget {
  const AdminTransactionsScreen({super.key});

  @override
  State<AdminTransactionsScreen> createState() =>
      _AdminTransactionsScreenState();
}

class _AdminTransactionsScreenState extends State<AdminTransactionsScreen> {
  int _selectedIndex = 1; // Drawer selected index for Transactions
  String _searchQuery = "";
  String _selectedStatus = "All Status";

  final List<Map<String, dynamic>> _transactions = [
    {
      "id": "TXN-001",
      "customer": "John Doe",
      "shop": "Mobile Masters",
      "type": "Repair",
      "amount": 150.0,
      "status": "Completed",
      "date": "2024-01-20"
    },
    {
      "id": "TXN-002",
      "customer": "Jane Smith",
      "shop": "TechFix Pro",
      "type": "Purchase",
      "amount": 89.99,
      "status": "Pending",
      "date": "2024-01-21"
    },
    {
      "id": "TXN-003",
      "customer": "Mike Johnson",
      "shop": "Device Doctor",
      "type": "Repair",
      "amount": 220.0,
      "status": "In Progress",
      "date": "2024-01-19"
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Filtered transactions
    final filteredTransactions = _transactions.where((txn) {
      final matchesSearch = txn["customer"]
          .toString()
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
      final matchesStatus =
          _selectedStatus == "All Status" || txn["status"] == _selectedStatus;
      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(

      drawer: AdminDrawerWidget(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Transaction Management",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "View and manage all repairs and purchases",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Filters row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search transactions...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) {
                      setState(() => _searchQuery = val);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                DropdownButton<String>(
                  value: _selectedStatus,
                  items: [
                    "All Status",
                    "Completed",
                    "Pending",
                    "In Progress",
                  ]
                      .map((status) =>
                      DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedStatus = val);
                    }
                  },
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement export logic
                  },
                  icon: const Icon(Icons.download),
                  label: const Text("Export"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Data Table (scrollable horizontally)
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey, width: 1), // 👈 grey border
              ),
              elevation: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Transaction ID")),
                    DataColumn(label: Text("Customer")),
                    DataColumn(label: Text("Repair Shop")),
                    DataColumn(label: Text("Type")),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Date")),
                  ],
                  rows: filteredTransactions.map((txn) {
                    return DataRow(cells: [
                      DataCell(Text(txn["id"])),
                      DataCell(Text(txn["customer"])),
                      DataCell(Text(txn["shop"])),
                      DataCell(Text(txn["type"])),
                      DataCell(Text("\$${txn["amount"].toStringAsFixed(2)}")),
                      DataCell(_buildStatusChip(txn["status"])),
                      DataCell(Text(txn["date"])),
                    ]);
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // ===== Status Chip =====
  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case "Completed":
        color = Colors.green;
        break;
      case "Pending":
        color = Colors.orange;
        break;
      case "In Progress":
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
