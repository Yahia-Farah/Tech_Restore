import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _users = [
    {
      "name": "Mokhtar",
      "email": "Mokhtar@repairdevices.com",
      "status": "Active",
      "joined": "2025-07-08",
      "orders": 7,
    },
    {
      "name": "Youssef Ehab",
      "email": "youssef@repairdevices.com",
      "status": "Active",
      "joined": "2025-07-08",
      "orders": 2,
    },
    {
      "name": "Mahmoud Ali",
      "email": "mahmoud@repairdevices.com",
      "status": "Active",
      "joined": "2025-07-08",
      "orders": 1,
    },
    {
      "name": "Ahmed Ashraf",
      "email": "ahmed@repairdevices.com",
      "status": "Pending",
      "joined": "2025-07-08",
      "orders": 7,
    },
    {
      "name": "Mohamed Haytham",
      "email": "mohamed@repairdevices.com",
      "status": "Active",
      "joined": "2025-07-08",
      "orders": 7,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "User Management",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
          
              // Search bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search users...",
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

// Table card
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 2,
                child: Column(
                  children: [
                    // 👇 Scroll only table, not footer
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          // Header row
                          Container(
                            color: Colors.grey[100],
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                            child: Row(
                              children: const [
                                SizedBox(width: 150, child: Text("Name")),
                                SizedBox(width: 220, child: Text("Email")),
                                SizedBox(width: 100, child: Text("Status")),
                                SizedBox(width: 120, child: Text("Joined")),
                                SizedBox(width: 100, child: Text("Orders")),
                                SizedBox(width: 150, child: Text("Actions")),
                              ],
                            ),
                          ),

                          // Users rows
                          ..._users.map((user) => _buildUserRow(user)),
                        ],
                      ),
                    ),

                    // 👇 Footer OUTSIDE horizontal scroll (fixed)
                    Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Showing 1 to ${_users.length} of 7",
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
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserRow(Map<String, dynamic> user) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text(user["name"])),
          SizedBox(width: 220, child: Text(user["email"])),
          SizedBox(width: 100, child: _buildStatusChip(user["status"])),
          SizedBox(width: 120, child: Text(user["joined"])),
          SizedBox(width: 100, child: Text(user["orders"].toString())),

          // Actions
          SizedBox(
            width: 150,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                  onPressed: () {},
                ),
                if (user["status"] == "Pending")
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    onPressed: () {},
                  ),
                IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {},
                ),
              ],
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
      case "Active":
        bg = Colors.green.withOpacity(0.2);
        text = Colors.green;
        break;
      case "Pending":
        bg = Colors.orange.withOpacity(0.2);
        text = Colors.orange;
        break;
      default:
        bg = Colors.red.withOpacity(0.2);
        text = Colors.red;
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
