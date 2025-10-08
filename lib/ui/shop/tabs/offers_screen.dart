import 'package:flutter/material.dart';
import '../../../core/l10n/translation/app_localizations.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  final List<Map<String, dynamic>> offers = [
    {
      "title": "New Year Special",
      "content": "20% off all screen repairs",
      "discount": "20%",
      "duration": "2024-01-01 to 2024-01-31",
      "status": "Active",
    },
    {
      "title": "Student Discount",
      "content": "\$10 off repairs with student ID",
      "discount": "\$10",
      "duration": "2024-01-15 to 2024-12-31",
      "status": "Active",
    },
    {
      "title": "Summer Sale",
      "content": "15% off all services",
      "discount": "15%",
      "duration": "2024-06-01 to 2024-08-31",
      "status": "Scheduled",
    },
    {
      "title": "Black Friday Deal",
      "content": "50% off accessories",
      "discount": "50%",
      "duration": "2023-11-24 to 2023-11-26",
      "status": "Expired",
    },
  ];

  String searchQuery = "";
  int currentPage = 1;
  final int itemsPerPage = 4;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final filteredOffers = offers
        .where((offer) =>
    offer["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        offer["content"].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    final totalPages = (filteredOffers.length / itemsPerPage).ceil();
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = (startIndex + itemsPerPage < filteredOffers.length)
        ? startIndex + itemsPerPage
        : filteredOffers.length;

    final currentOffers = filteredOffers.sublist(startIndex, endIndex);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                      local.offersTitle, // localized
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      local.offersSubtitle, // localized
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Search + Add Offer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: local.searchOffers, // localized
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
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade50,
                      foregroundColor: Colors.blue,
                    ),
                    label: Text(local.addNewOffer), // localized
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
                          DataColumn(label: Text(local.offerColumnTitle)),
                          DataColumn(label: Text(local.offerColumnContent)),
                          DataColumn(label: Text(local.offerColumnDiscount)),
                          DataColumn(label: Text(local.offerColumnDuration)),
                          DataColumn(label: Text(local.offerColumnStatus)),
                          DataColumn(label: Text(local.offerColumnActions)),
                        ],
                        rows: currentOffers
                            .map(
                              (offer) => _buildOfferRow(
                            offer["title"],
                            offer["content"],
                            offer["discount"],
                            offer["duration"],
                            offer["status"],
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
                            "${startIndex + 1} ${local.toShow} $endIndex ${local.ofShow} ${filteredOffers.length} ${local.offersTitle}",
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.chevron_left),
                                onPressed: currentPage > 1
                                    ? () => setState(() => currentPage--)
                                    : null,
                              ),
                              for (int i = 1; i <= totalPages; i++)
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: currentPage == i
                                          ? Colors.blue
                                          : Colors.grey.shade300,
                                      foregroundColor: currentPage == i
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onPressed: () =>
                                        setState(() => currentPage = i),
                                    child: Text("$i"),
                                  ),
                                ),
                              IconButton(
                                icon: const Icon(Icons.chevron_right),
                                onPressed: currentPage < totalPages
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
      ),
    );
  }

  DataRow _buildOfferRow(
      String title,
      String content,
      String discount,
      String duration,
      String status,
      ) {
    Color statusColor;
    switch (status) {
      case "Active":
        statusColor = Colors.green;
        break;
      case "Scheduled":
        statusColor = Colors.blue;
        break;
      case "Expired":
        statusColor = Colors.black;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(Text(title)),
        DataCell(Text(content)),
        DataCell(Text(discount)),
        DataCell(Text(duration)),
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
        DataCell(
          Row(
            children: const [
              Icon(Icons.edit, color: Colors.blue),
              SizedBox(width: 8),
              Icon(Icons.delete, color: Colors.red),
            ],
          ),
        ),
      ],
    );
  }
}
