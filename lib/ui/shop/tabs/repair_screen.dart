import 'package:flutter/material.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  String _searchQuery = "";
  String _selectedStatus = "حالة الطلب";
  int _currentPage = 1;
  final int _rowsPerPage = 5;

  final List<Map<String, String>> _allRequests = [
    {
      "client": "Mahmoud Ali",
      "device": "iPhone 16",
      "issue": "Screen replacement",
      "status": "Received",
      "date": "2025-05-15",
    },
    {
      "client": "Youssef Ehab",
      "device": "iPhone 15",
      "issue": "Battery replacement",
      "status": "In Progress",
      "date": "2025-05-14",
    },
    {
      "client": "Ahmed Samir",
      "device": "Samsung Galaxy S24",
      "issue": "Charging port repair",
      "status": "Completed",
      "date": "2025-05-10",
    },
    {
      "client": "Fatima Hassan",
      "device": "Google Pixel 8",
      "issue": "Camera replacement",
      "status": "Received",
      "date": "2025-05-16",
    },
    {
      "client": "Omar Khalid",
      "device": "OnePlus 12",
      "issue": "Water damage repair",
      "status": "In Progress",
      "date": "2025-05-12",
    },
    {
      "client": "Sara Ahmed",
      "device": "Huawei P60",
      "issue": "Software issue",
      "status": "Completed",
      "date": "2025-05-11",
    },
    {
      "client": "Khaled Mohamed",
      "device": "iPad Pro",
      "issue": "Speaker replacement",
      "status": "Received",
      "date": "2025-05-17",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 🔹 Apply filters
    final filteredRequests =
        _allRequests.where((req) {
          final matchesSearch =
              req["client"]!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              req["device"]!.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              req["issue"]!.toLowerCase().contains(_searchQuery.toLowerCase());

          final matchesStatus =
              _selectedStatus == "حالة الطلب" || req["status"] == _selectedStatus;

          return matchesSearch && matchesStatus;
        }).toList();
    final totalPages = (filteredRequests.length / _rowsPerPage).ceil();
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final endIndex = (_currentPage * _rowsPerPage).clamp(
      0,
      filteredRequests.length,
    );
    final currentPageItems = filteredRequests.sublist(startIndex, endIndex);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "طلبات التصليح",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "يمكنك رؤية جميع طلبات التصليح الخاصة بالعملاء و قبولها و تعديل حالة الطلب من هنا",
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 Search + Filter
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "ابحث...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                      _currentPage = 1; // reset page
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: _selectedStatus,
                items: const [
                  DropdownMenuItem(value: "حالة الطلب", child: Text("حالة الطلب")),
                  DropdownMenuItem(value: "Received", child: Text("Received")),
                  DropdownMenuItem(
                    value: "In Progress",
                    child: Text("In Progress"),
                  ),
                  DropdownMenuItem(
                    value: "Completed",
                    child: Text("Completed"),
                  ),
                ],
                onChanged: (val) {
                  setState(() {
                    _selectedStatus = val!;
                    _currentPage = 1; // reset page
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 🔹 DataTable
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("العميل")),
                DataColumn(label: Text("الجهاز")),
                DataColumn(label: Text("العطل")),
                DataColumn(label: Text("حالة الطلب")),
                DataColumn(label: Text("التاريخ")),
                DataColumn(label: Text("اتخاذ قرار")),
              ],
              rows:
                  currentPageItems
                      .map(
                        (req) => _buildRepairRow(
                          req["client"]!,
                          req["device"]!,
                          req["issue"]!,
                          req["status"]!,
                          req["date"]!,
                        ),
                      )
                      .toList(),
            ),
          ),

          const SizedBox(height: 12),

          // 🔹 Footer with pagination
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${startIndex + 1} to $endIndex of ${filteredRequests.length} requests",
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
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _currentPage == i
                                  ? Colors.blue
                                  : Colors.grey.shade300,
                          foregroundColor:
                              _currentPage == i ? Colors.white : Colors.black,
                        ),
                        onPressed: () => setState(() => _currentPage = i),
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
        ],
      ),
    );
  }

  DataRow _buildRepairRow(
    String client,
    String device,
    String issue,
    String status,
    String date,
  ) {
    Color statusColor;
    switch (status) {
      case "Received":
        statusColor = Colors.blue;
        break;
      case "In Progress":
        statusColor = Colors.orange;
        break;
      case "Completed":
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(Text(client)),
        DataCell(Text(device)),
        DataCell(Text(issue, style: const TextStyle(color: Colors.blue))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(status, style: TextStyle(color: statusColor)),
          ),
        ),
        DataCell(Text(date)),
        DataCell(
          Row(
            children: const [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 8),
              Icon(Icons.timer, color: Colors.orange),
              SizedBox(width: 8),
              Icon(Icons.check_circle, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }
}
