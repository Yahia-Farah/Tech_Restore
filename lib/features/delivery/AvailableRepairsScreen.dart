import 'package:flutter/material.dart';

import 'MyDeliveriesScreen.dart';

class AvailableRepairsScreen extends StatelessWidget {
  const AvailableRepairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5748E6),
        title: const Text("Available Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: AvailableOrderCard(
            id: "#0199a942",
            address1: "11th street, Cairo, Cairo",
            address2: "50th Street, Cairo, Cairo",
            price: "28000 EGP",
            date: "10/3/2025, 10:48 AM",
            status: "FINISH PROCESSING",
          ),
        ),
      ),
    );
  }
}

class AvailableOrderCard extends StatelessWidget {
  final String id;
  final String address1;
  final String address2;
  final String price;
  final String date;
  final String status;

  const AvailableOrderCard({
    super.key,
    required this.id,
    required this.address1,
    required this.address2,
    required this.price,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 330,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order $id",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          InfoRow(icon: Icons.location_on, text: address1),
          InfoRow(icon: Icons.location_on, text: address2),
          InfoRow(icon: Icons.payments_outlined, text: price),
          InfoRow(icon: Icons.calendar_today, text: date),
          const SizedBox(height: 10),

          /// Status colored
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              "Status: $status",
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Accept / Reject Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5748E6),
                  ),
                  child: const Text("Accept"),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                  ),
                  child: const Text("Reject"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
