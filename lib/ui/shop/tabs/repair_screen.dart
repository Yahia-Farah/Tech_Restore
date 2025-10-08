import 'package:flutter/material.dart';
import '../../../core/l10n/translation/app_localizations.dart';

class RepairScreen extends StatefulWidget {
  const RepairScreen({super.key});

  @override
  State<RepairScreen> createState() => _RepairScreenState();
}

class _RepairScreenState extends State<RepairScreen> {
  String _searchQuery = "";
  String _selectedStatus = "all"; // ✅ stable default key
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
    final local = AppLocalizations.of(context)!;

    // 🔹 Map status keys → localized text
    final statusOptions = {
      "all": local.status_filter,
      "Received": local.status_received,
      "In Progress": local.status_in_progress,
      "Completed": local.status_completed,
    };

    // 🔹 Apply filters
    final filteredRequests = _allRequests.where((req) {
      final matchesSearch = req["client"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          req["device"]!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          req["issue"]!.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesStatus = _selectedStatus == "all" || req["status"] == _selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();

    final totalPages = (filteredRequests.length / _rowsPerPage).ceil();
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final endIndex = (_currentPage * _rowsPerPage).clamp(0, filteredRequests.length);
    final currentPageItems = filteredRequests.sublist(startIndex, endIndex);

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
                  local.repair_requests_title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  local.repair_requests_subtitle,
                  style: const TextStyle(color: Colors.black54),
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
                    hintText: local.search_hint,
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
                items: statusOptions.entries
                    .map((entry) => DropdownMenuItem(
                  value: entry.key,
                  child: Text(entry.value),
                ))
                    .toList(),
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

          Card(
            child: Column(
              children: [
                // 🔹 DataTable
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text(local.table_client)),
                      DataColumn(label: Text(local.table_device)),
                      DataColumn(label: Text(local.table_issue)),
                      DataColumn(label: Text(local.table_status)),
                      DataColumn(label: Text(local.table_date)),
                      DataColumn(label: Text(local.table_action)),
                    ],
                    rows: currentPageItems
                        .map((req) => _buildRepairRow(
                      context,
                      req["client"]!,
                      req["device"]!,
                      req["issue"]!,
                      req["status"]!,
                      req["date"]!,
                    ))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 12),

                // 🔹 Footer with pagination
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredRequests.length} ${local.requestsCount}"),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: _currentPage > 1
                                ? () => setState(() => _currentPage--)
                                : null,
                          ),
                          for (int i = 1; i <= totalPages; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _currentPage == i
                                      ? Colors.blue
                                      : Colors.grey.shade300,
                                  foregroundColor: _currentPage == i
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                onPressed: () => setState(() => _currentPage = i),
                                child: Text("$i"),
                              ),
                            ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: _currentPage < totalPages
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
          )
        ],
      ),
    );
  }

  DataRow _buildRepairRow(
      BuildContext context,
      String client,
      String device,
      String issue,
      String status,
      String date,
      ) {
    final local = AppLocalizations.of(context)!;

    String localizedStatus;
    Color statusColor;

    switch (status) {
      case "Received":
        localizedStatus = local.status_received;
        statusColor = Colors.blue;
        break;
      case "In Progress":
        localizedStatus = local.status_in_progress;
        statusColor = Colors.orange;
        break;
      case "Completed":
        localizedStatus = local.status_completed;
        statusColor = Colors.green;
        break;
      default:
        localizedStatus = status;
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
            child: Text(localizedStatus, style: TextStyle(color: statusColor)),
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
