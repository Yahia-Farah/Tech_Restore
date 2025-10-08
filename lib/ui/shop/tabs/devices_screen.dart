import 'package:flutter/material.dart';
import '../../../core/l10n/translation/app_localizations.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> devices = [
    {
      "name": "iPhone 13\nIncludes original box and charger",
      "type": "Smartphone",
      "serial": "SN12345678",
      "price": "699 EGP",
      "quantity": 5,
      "status": "new"
    },
    {
      "name": "Samsung Galaxy S21\nMinor scratches on back",
      "type": "Smartphone",
      "serial": "SN87654321",
      "price": "649 EGP",
      "quantity": 3,
      "status": "used"
    },
    {
      "name": "iPad Pro\n2022 model with M1 chip",
      "type": "Tablet",
      "serial": "SN13579246",
      "price": "799 EGP",
      "quantity": 0,
      "status": "new"
    },
    {
      "name": "MacBook Air\nApple certified refurbished",
      "type": "Laptop",
      "serial": "SN24681357",
      "price": "999 EGP",
      "quantity": 2,
      "status": "new"
    },
  ];

  String selectedFilter = "all";

  // Pagination state
  int currentPage = 1;
  static const int devicesPerPage = 4;

  List<Map<String, dynamic>> get filteredDevices {
    final searchText = _searchController.text.toLowerCase();
    return devices.where((device) =>
        device["name"].toString().toLowerCase().contains(searchText)
    ).toList();
  }

  List<Map<String, dynamic>> get paginatedDevices {
    final start = (currentPage - 1) * devicesPerPage;
    final end = (start + devicesPerPage) > filteredDevices.length ? filteredDevices.length : (start + devicesPerPage);
    return filteredDevices.sublist(start, end);
  }

  int get totalPages => (filteredDevices.length / devicesPerPage).ceil().clamp(1, 999);

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

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
                  local.devices_management,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                const SizedBox(height: 8),
                Text(
                  local.devices_management_desc,
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // 🔹 Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent),
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text(local.add_device, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: local.search_hint,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentPage = 1; // Reset to first page on search
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          // 🔹 Search + Filters
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600),
                icon: const Icon(Icons.devices, color: Colors.white),
                label: Text(local.device_types, style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedFilter = "status";
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600),
                child: Text(local.device_status, style: const TextStyle(color: Colors.white)),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedFilter = "all";
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade600),
                child: Text(local.all_types, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 🔹 Devices Table
          Card(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text(local.device_name)),
                      DataColumn(label: Text(local.device_type)),
                      DataColumn(label: Text(local.serial_number)),
                      DataColumn(label: Text(local.price)),
                      DataColumn(label: Text(local.quantity)),
                      DataColumn(label: Text(local.status)),
                      DataColumn(label: Text(local.actions)),
                    ],
                    rows: paginatedDevices.map((device) => _buildDeviceRow(device, local)).toList(),
                  ),
                ),

                const SizedBox(height: 12),

                // 🔹 Pagination footer
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${filteredDevices.isEmpty ? 0 : ((currentPage - 1) * devicesPerPage + 1)} ${local.toShow} ${((currentPage * devicesPerPage) > filteredDevices.length ? filteredDevices.length : (currentPage * devicesPerPage))} ${local.ofShow} ${filteredDevices.length} ${local.devices}",
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
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: currentPage == i ? Colors.blue : Colors.grey.shade300,
                                  foregroundColor: currentPage == i ? Colors.white : Colors.black,
                                ),
                                onPressed: () => setState(() => currentPage = i),
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  DataRow _buildDeviceRow(Map<String, dynamic> device, AppLocalizations local) {
    Color statusColor = device["status"] == "new" ? Colors.green : Colors.red;
    Color bgColor = device["status"] == "new"
        ? Colors.green.withOpacity(0.1)
        : Colors.red.withOpacity(0.1);

    return DataRow(cells: [
      DataCell(Text(device["name"])),
      DataCell(Text(device["type"])),
      DataCell(Text(device["serial"])),
      DataCell(Text(device["price"])),
      DataCell(Text(device["quantity"].toString())),
      DataCell(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            device["status"] == "new" ? local.newDev : local.used,
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      DataCell(Row(
        children: [
          Icon(Icons.edit, color: Colors.blue, semanticLabel: local.edit),
          const SizedBox(width: 8),
          Icon(Icons.delete, color: Colors.red, semanticLabel: local.delete),
        ],
      )),
    ]);
  }
}
