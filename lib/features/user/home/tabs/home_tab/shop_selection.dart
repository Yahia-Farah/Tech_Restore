import 'package:flutter/material.dart';

class SelectRepairShopScreen extends StatefulWidget {
  static const String routename = "shop_selection";

  const SelectRepairShopScreen({super.key});
  @override
  _SelectRepairShopScreenState createState() => _SelectRepairShopScreenState();
}

class _SelectRepairShopScreenState extends State<SelectRepairShopScreen> {
  final List<Map<String, String>> shops = [
    {
      "name": "Sigma Computer",
      "status": "Open · Closes at 12:00 AM",
      "rating": "4.5 (1,300 ratings) · 0.8mi",
      "logo": "https://via.placeholder.com/50", // Replace with actual
    },
    {
      "name": "Dream2000 Stores",
      "status": "Open · Closes at 12:00 AM",
      "rating": "4.6 (1,250 ratings) · 0.8mi",
      "logo": "https://via.placeholder.com/50",
    },
    {
      "name": "TechRestore",
      "status": "Open · Closes at 12:00 AM",
      "rating": "4.5 (1,250 ratings) · 0.8mi",
      "logo": "https://via.placeholder.com/50",
    },
    {
      "name": "Tradeline - Apple",
      "status": "Open · Closes at 12:00 AM",
      "rating": "4.8 (4,200 ratings) · 0.8mi",
      "logo": "https://via.placeholder.com/50",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select a repair shop"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for a shop",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          // Filter tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                FilterChip(
                  label: Text("All"),
                  selected: true,
                  onSelected: (_) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text("Apple"),
                  selected: false,
                  onSelected: (_) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text("Samsung"),
                  selected: false,
                  onSelected: (_) {},
                ),
                SizedBox(width: 8),
                FilterChip(
                  label: Text("Huawei"),
                  selected: false,
                  onSelected: (_) {},
                ),
              ],
            ),
          ),
          SizedBox(height: 10),

          // Shops list
          Expanded(
            child: ListView.builder(
              itemCount: shops.length,
              itemBuilder: (context, index) {
                final shop = shops[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(shop["logo"]!),
                  ),
                  title: Text(
                    shop["name"]!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(shop["status"]!), Text(shop["rating"]!)],
                  ),
                );
              },
            ),
          ),

          // Select button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle selection
                },
                child: Text(
                  "Select this shop",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
