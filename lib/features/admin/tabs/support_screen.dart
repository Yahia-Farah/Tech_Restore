import 'package:flutter/material.dart';
import '../widgets/admin_drawer.dart';

class AdminSupportScreen extends StatefulWidget {
  const AdminSupportScreen({super.key});

  @override
  State<AdminSupportScreen> createState() => _AdminSupportScreenState();
}

class _AdminSupportScreenState extends State<AdminSupportScreen> {
  int _selectedIndex = 1;
  String _searchQuery = "";
  String _selectedStatus = "All Status";

  final List<Map<String, dynamic>> _requests = [
    {
      "id": "SUP-001",
      "customer": "John Doe",
      "subject": "Delayed repair delivery",
      "priority": "High",
      "status": "Open",
      "assigned": "Sarah Admin",
      "lastUpdate": "2024-01-20",
    },
    {
      "id": "SUP-002",
      "customer": "Jane Smith",
      "subject": "Refund request for cancelled repair",
      "priority": "Medium",
      "status": "In Progress",
      "assigned": "Mike Support",
      "lastUpdate": "2024-01-21",
    },
    {
      "id": "SUP-003",
      "customer": "Mike Johnson",
      "subject": "Question about warranty coverage",
      "priority": "Low",
      "status": "Resolved",
      "assigned": "Lisa Help",
      "lastUpdate": "2024-01-19",
    },
    {
      "id": "SUP-004",
      "customer": "Sarah Wilson",
      "subject": "Complaint about repair quality",
      "priority": "High",
      "status": "Open",
      "assigned": "Tom Manager",
      "lastUpdate": "2024-01-17",
    },
    {
      "id": "SUP-005",
      "customer": "Tom Brown",
      "subject": "Unable to track repair status",
      "priority": "Medium",
      "status": "Open",
      "assigned": "Sarah Admin",
      "lastUpdate": "2024-01-16",
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
    // Filtered requests
    final filteredRequests =
        _requests.where((req) {
          final matchesSearch =
              req["customer"].toString().toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              req["subject"].toString().toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );
          final matchesStatus =
              _selectedStatus == "All Status" ||
              req["status"] == _selectedStatus;
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
              "Support Requests",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Manage customer support requests and complaints",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // Filters row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search requests...",
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
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
                  items:
                      ["All Status", "Open", "In Progress", "Resolved"]
                          .map(
                            (status) => DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            ),
                          )
                          .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedStatus = val);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Data Table
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
                    DataColumn(label: Text("Request ID")),
                    DataColumn(label: Text("Customer")),
                    DataColumn(label: Text("Subject")),
                    DataColumn(label: Text("Priority")),
                    DataColumn(label: Text("Status")),
                    DataColumn(label: Text("Assigned To")),
                    DataColumn(label: Text("Last Update")),
                    DataColumn(label: Text("Actions")),
                  ],
                  rows:
                      filteredRequests.map((req) {
                        return DataRow(
                          cells: [
                            DataCell(Text(req["id"])),
                            DataCell(Text(req["customer"])),
                            DataCell(
                              Text(
                                req["subject"],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            DataCell(_buildPriorityChip(req["priority"])),
                            DataCell(_buildStatusChip(req["status"])),
                            DataCell(Text(req["assigned"])),
                            DataCell(Text(req["lastUpdate"])),
                            DataCell(
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.chat_bubble_outline),
                                    onPressed: () {
                                      // TODO: Open chat
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.refresh),
                                    onPressed: () {
                                      // TODO: Refresh request
                                    },
                                  ),
                                ],
                              ),
                            ),
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

  // ===== Priority Chip =====
  Widget _buildPriorityChip(String priority) {
    Color color;
    switch (priority) {
      case "High":
        color = Colors.red;
        break;
      case "Medium":
        color = Colors.orange;
        break;
      case "Low":
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
        priority,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ===== Status Chip =====
  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case "Open":
        color = Colors.red;
        break;
      case "In Progress":
        color = Colors.orange;
        break;
      case "Resolved":
        color = Colors.green;
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
