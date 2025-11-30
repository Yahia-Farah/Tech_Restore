import 'package:flutter/material.dart';
import '../widgets/admin_drawer.dart';

class AdminPromotionsScreen extends StatefulWidget {
  const AdminPromotionsScreen({super.key});

  @override
  State<AdminPromotionsScreen> createState() => _AdminPromotionsScreenState();
}

class _AdminPromotionsScreenState extends State<AdminPromotionsScreen> {
  int _selectedIndex = 1;
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _offers = [
    {
      "title": "New Year Special",
      "description": "20% off all screen repairs",
      "discount": "20%",
      "duration": "2024-01-01 to 2024-01-31",
      "status": "Active",
      "usage": 45,
    },
    {
      "title": "Student Discount",
      "description": "\$10 off repairs with student ID",
      "discount": "\$10",
      "duration": "2024-01-15 to 2024-12-31",
      "status": "Active",
      "usage": 23,
    },
    {
      "title": "Summer Sale",
      "description": "15% off all services",
      "discount": "15%",
      "duration": "2024-06-01 to 2024-08-31",
      "status": "Scheduled",
      "usage": 0,
    },
    {
      "title": "Black Friday Deal",
      "description": "50% off accessories",
      "discount": "50%",
      "duration": "2023-11-24 to 2023-11-26",
      "status": "Expired",
      "usage": 156,
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
    final filteredOffers =
        _offers.where((offer) {
          final query = _searchQuery.toLowerCase();
          return offer["title"].toLowerCase().contains(query) ||
              offer["description"].toLowerCase().contains(query);
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
              "Promotional Offers",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Create and manage promotional offers and discounts",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Search + Create Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search offers...",
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
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Add navigation to create offer screen
                  },
                  icon: const Icon(Icons.add),
                  label: const Text("Create Offer"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Offers Table
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Colors.grey, width: 1),
              ),
              elevation: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text("Title")),
                    DataColumn(label: Text("Description")),
                    DataColumn(label: Text("Discount")),
                    DataColumn(label: Text("Duration")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Usage")),
                  ],
                  rows:
                      filteredOffers.map((offer) {
                        return DataRow(
                          cells: [
                            DataCell(Text(offer["title"])),
                            DataCell(Text(offer["description"])),
                            DataCell(Text(offer["discount"])),
                            DataCell(Text(offer["duration"])),
                            DataCell(_buildStatusChip(offer["status"])),
                            DataCell(Text("${offer["usage"]} uses")),
                          ],
                        );
                      }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Status Chip =====
  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case "Active":
        color = Colors.green;
        break;
      case "Scheduled":
        color = Colors.blue;
        break;
      case "Expired":
        color = Colors.grey;
        break;
      default:
        color = Colors.black;
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
