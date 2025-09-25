import 'package:flutter/material.dart';

class AdminRepairScreen extends StatefulWidget {
  const AdminRepairScreen({super.key});

  @override
  State<AdminRepairScreen> createState() => _AdminRepairScreenState();
}

class _AdminRepairScreenState extends State<AdminRepairScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _shops = [
    {
      "name": "TechFix Pro",
      "owner": "Alex Johnson",
      "location": "New York, NY",
      "status": "Pending",
      "rating": null,
      "joinDate": "2024-01-20"
    },
    {
      "name": "Mobile Masters",
      "owner": "Sarah Chen",
      "location": "Los Angeles, CA",
      "status": "Approved",
      "rating": 4.8,
      "joinDate": "2024-01-15"
    },
    {
      "name": "Quick Repair Hub",
      "owner": "Mike Wilson",
      "location": "Chicago, IL",
      "status": "Suspended",
      "rating": 3.2,
      "joinDate": "2024-01-10"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Repair Shop Management",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Approve, suspend, and manage repair shop registrations",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Card wrapper
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Title + Search
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Repair Shops",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "Search repair shops...",
                              prefixIcon: const Icon(Icons.search),
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 👇 Scrollable table (only)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          // Table header
                          Container(
                            color: Colors.grey[200],
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            child: Row(
                              children: const [
                                SizedBox(width: 160, child: Text("Shop Name")),
                                SizedBox(width: 160, child: Text("Owner")),
                                SizedBox(width: 200, child: Text("Location")),
                                SizedBox(width: 100, child: Text("Status")),
                                SizedBox(width: 100, child: Text("Rating")),
                                SizedBox(width: 120, child: Text("Join Date")),
                                SizedBox(width: 100, child: Text("Action")),
                              ],
                            ),
                          ),

                          // Shops list
                          ..._shops.map((shop) => _buildShopRow(shop)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 👇 Pagination OUTSIDE horizontal scroll
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Showing 1 to ${_shops.length} of ${_shops.length} users",
                          style: const TextStyle(fontSize: 12),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_left),
                              onPressed: () {},
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "1",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text("2"),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_right),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopRow(Map<String, dynamic> shop) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          SizedBox(width: 160, child: Text(shop["name"])),
          SizedBox(width: 160, child: Text(shop["owner"])),
          SizedBox(width: 200, child: Text(shop["location"])),
          SizedBox(width: 100, child: _buildStatusChip(shop["status"])),
          SizedBox(
            width: 100,
            child: shop["rating"] != null
                ? Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(shop["rating"].toString()),
              ],
            )
                : const Text("No ratings"),
          ),
          SizedBox(width: 120, child: Text(shop["joinDate"])),
          SizedBox(
            width: 100,
            child: IconButton(
              icon: const Icon(Icons.remove_red_eye_outlined),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color bg;
    Color text;
    switch (status) {
      case "Approved":
        bg = Colors.green.withOpacity(0.2);
        text = Colors.green;
        break;
      case "Suspended":
        bg = Colors.red.withOpacity(0.2);
        text = Colors.red;
        break;
      default:
        bg = Colors.orange.withOpacity(0.2);
        text = Colors.orange;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration:
      BoxDecoration(color: bg, borderRadius: BorderRadius.circular(8)),
      child: Text(
        status,
        style: TextStyle(color: text, fontSize: 12),
      ),
    );
  }
}
