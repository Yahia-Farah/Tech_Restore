import 'package:flutter/material.dart';

import '../../../../../../core/theme/app_colors.dart';

class AdminReviewsScreen extends StatefulWidget {
  const AdminReviewsScreen({super.key});

  @override
  State<AdminReviewsScreen> createState() => _AdminReviewsScreenState();
}

class _AdminReviewsScreenState extends State<AdminReviewsScreen> {
  String _searchQuery = "";
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _reviews = [
    {
      "customer": "John Doe",
      "shop": "Mobile Masters",
      "rating": 5,
      "comment": "Excellent service! Fixed my phone quickly.",
      "date": "2024-01-20",
      "status": "Positive",
    },
    {
      "customer": "Jane Smith",
      "shop": "TechFix Pro",
      "rating": 1,
      "comment": "Terrible service! They broke my phone.",
      "date": "2024-01-19",
      "status": "Negative",
    },
    {
      "customer": "Mike Johnson",
      "shop": "Device Doctor",
      "rating": 4,
      "comment": "Good service, reasonable prices.",
      "date": "2024-01-18",
      "status": "Positive",
    },
    {
      "customer": "Sarah Wilson",
      "shop": "Quick Repair Hub",
      "rating": 2,
      "comment": "This place is a scam! They overcharged me.",
      "date": "2024-01-17",
      "status": "Negative",
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredReviews =
        _reviews.where((review) {
          final query = _searchQuery.toLowerCase();
          return review["customer"].toLowerCase().contains(query) ||
              review["shop"].toLowerCase().contains(query) ||
              review["comment"].toLowerCase().contains(query);
        }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Review Management",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 4),
            const Text(
              "Monitor and manage customer reviews",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Search bar
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (val) {
                setState(() => _searchQuery = val);
              },
            ),
            const SizedBox(height: 20),

            // Review Table
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
                    DataColumn(label: Text("Customer")),
                    DataColumn(label: Text("Repair Shop")),
                    DataColumn(label: Text("Rating")),
                    DataColumn(label: Text("Comment")),
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Status")),
                  ],
                  rows:
                      filteredReviews.map((review) {
                        return DataRow(
                          cells: [
                            DataCell(Text(review["customer"])),
                            DataCell(Text(review["shop"])),
                            DataCell(_buildStarRating(review["rating"])),
                            DataCell(
                              Text(
                                review["comment"],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DataCell(Text(review["date"])),
                            DataCell(_buildStatusChip(review["status"])),
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

  // ===== Rating Stars =====
  Widget _buildStarRating(int rating) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 18,
        );
      }),
    );
  }

  // ===== Status Chip =====
  Widget _buildStatusChip(String status) {
    Color color = status == "Positive" ? Colors.green : Colors.red;
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


