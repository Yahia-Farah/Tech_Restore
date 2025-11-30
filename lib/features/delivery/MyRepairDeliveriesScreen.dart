import 'package:flutter/material.dart';

class MyRepairDeliveriesScreen extends StatelessWidget {
  const MyRepairDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5748E6),
        title: const Text("My Repair Deliveries"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            RepairCard(
              id: "#01998b4f",
              address: "11th street, Cairo",
              price: "EGP",
              date: "9/25/2025, 4:23 PM",
              status: "DEVICE_DELIVERED",
            ),
            SizedBox(height: 16),
            RepairCard(
              id: "#01998b5b",
              address: "11th street, Cairo",
              price: "EGP",
              date: "9/21/2025, 4:25 PM",
              status: "DEVICE_DELIVERED",
            ),
          ],
        ),
      ),
    );
  }
}

class RepairCard extends StatelessWidget {
  final String id;
  final String address;
  final String price;
  final String date;
  final String status;

  const RepairCard({
    super.key,
    required this.id,
    required this.address,
    required this.price,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Repair $id",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 8),
          Text("Address: $address"),
          Text("Price: $price"),
          Text("Date: $date"),
          const SizedBox(height: 6),
          Text("Status: $status",
              style: const TextStyle(
                  color: Colors.green, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF5748E6),
            ),
            child: const Text("Update Status"),
          )
        ],
      ),
    );
  }
}
