import 'package:flutter/material.dart';
import '../../../core/l10n/translation/app_localizations.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final List<Map<String, dynamic>> requests = [
    {
      "id": "SUP-001",
      "customer": "John Doe",
      "content": "Delayed repair delivery",
      "priority": "High",
      "status": "Open",
      "lastUpdate": "2024-01-20",
    },
    {
      "id": "SUP-002",
      "customer": "Jane Smith",
      "content": "Refund request for cancelled service",
      "priority": "Medium",
      "status": "In Progress",
      "lastUpdate": "2024-01-21",
    },
    {
      "id": "SUP-003",
      "customer": "Mike Johnson",
      "content": "Question about warranty coverage",
      "priority": "Low",
      "status": "Resolved",
      "lastUpdate": "2024-01-19",
    },
    {
      "id": "SUP-004",
      "customer": "Sarah Wilson",
      "content": "Complaint about repair quality",
      "priority": "High",
      "status": "Open",
      "lastUpdate": "2024-01-17",
    },
    {
      "id": "SUP-005",
      "customer": "Tom Brown",
      "content": "Unable to track repair status",
      "priority": "Medium",
      "status": "Open",
      "lastUpdate": "2024-01-16",
    },
  ];

  String searchQuery = "";
  String selectedStatus = "all";
  int currentPage = 1;
  final int itemsPerPage = 5;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    final statusOptions = {
      "all": local.allStatus,
      "open": local.openStatus,
      "inProgress": local.inProgressStatus,
      "resolved": local.resolvedStatus,
    };

    // Filtering
    final filteredRequests =
        requests.where((req) {
          final matchesSearch =
              req["id"].toLowerCase().contains(searchQuery.toLowerCase()) ||
              req["customer"].toLowerCase().contains(
                searchQuery.toLowerCase(),
              ) ||
              req["content"].toLowerCase().contains(searchQuery.toLowerCase());

          final matchesStatus =
              selectedStatus == "all" ||
              req["status"].toLowerCase() == selectedStatus.toLowerCase();

          return matchesSearch && matchesStatus;
        }).toList();

    // Pagination
    final totalPages = (filteredRequests.length / itemsPerPage).ceil();
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex =
        (startIndex + itemsPerPage < filteredRequests.length)
            ? startIndex + itemsPerPage
            : filteredRequests.length;
    final currentRequests = filteredRequests.sublist(startIndex, endIndex);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
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
                    local.supportTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    local.supportSubtitle,
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search + Filter
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: local.searchSupport,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        currentPage = 1;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: selectedStatus,
                  items:
                      statusOptions.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value!;
                      currentPage = 1;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Table
            Card(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text(local.tableRequestId)),
                        DataColumn(label: Text(local.tableCustomer)),
                        DataColumn(label: Text(local.tableContent)),
                        DataColumn(label: Text(local.tablePriority)),
                        DataColumn(label: Text(local.tableStatus)),
                        DataColumn(label: Text(local.tableLastUpdate)),
                        DataColumn(label: Text(local.tableActions)),
                      ],
                      rows:
                          currentRequests
                              .map(
                                (req) => _buildSupportRow(
                                  req["id"],
                                  req["customer"],
                                  req["content"],
                                  req["priority"],
                                  req["status"],
                                  req["lastUpdate"],
                                ),
                              )
                              .toList(),
                    ),
                  ),

                  // Pagination
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredRequests.length} ${local.requestsCount}",
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.chevron_left),
                              onPressed:
                                  currentPage > 1
                                      ? () => setState(() => currentPage--)
                                      : null,
                            ),
                            for (int i = 1; i <= totalPages; i++)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        currentPage == i
                                            ? Colors.blue
                                            : Colors.grey.shade300,
                                    foregroundColor:
                                        currentPage == i
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  onPressed:
                                      () => setState(() => currentPage = i),
                                  child: Text("$i"),
                                ),
                              ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed:
                                  currentPage < totalPages
                                      ? () => setState(() => currentPage++)
                                      : null,
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
    );
  }

  DataRow _buildSupportRow(
    String id,
    String customer,
    String content,
    String priority,
    String status,
    String lastUpdate,
  ) {
    // Priority color
    Color priorityColor;
    switch (priority) {
      case "High":
        priorityColor = Colors.red;
        break;
      case "Medium":
        priorityColor = Colors.orange;
        break;
      case "Low":
        priorityColor = Colors.blue;
        break;
      default:
        priorityColor = Colors.grey;
    }

    // Status color
    Color statusColor;
    switch (status) {
      case "Open":
        statusColor = Colors.red;
        break;
      case "In Progress":
        statusColor = Colors.orange;
        break;
      case "Resolved":
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(customer)),
        DataCell(Text(content)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: priorityColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(priority, style: TextStyle(color: priorityColor)),
          ),
        ),
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
        DataCell(Text(lastUpdate)),
        const DataCell(
          Row(
            children: [
              Icon(Icons.chat, color: Colors.black54),
              SizedBox(width: 8),
              Icon(Icons.done, color: Colors.green),
              SizedBox(width: 8),
              Icon(Icons.close, color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}
