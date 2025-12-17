import 'package:flutter/material.dart';

class MyDeliveriesScreen extends StatelessWidget {
  const MyDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF5748E6),
        title: const Text("My Deliveries"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: const [
            DeliveryCard(
              id: "#01998f01",
              address: "11th street, Cairo",
              total: "18000 EGP",
              date: "9/28/2025, 8:28 AM",
              status: "DELIVERED",
            ),
            DeliveryCard(
              id: "#0199ab2b",
              address: "11th street, Cairo",
              total: "28000 EGP",
              date: "10/1/2025, 6:30 PM",
              status: "SHIPPED",
            ),
            DeliveryCard(
              id: "#0199a329",
              address: "11th street, Cairo",
              total: "28000 EGP",
              date: "10/1/2025, 7:24 AM",
              status: "SHIPPED",
            ),
            DeliveryCard(
              id: "#019993ae",
              address: "11th street, Cairo",
              total: "28000 EGP",
              date: "9/29/2025, 7:53 AM",
              status: "SHIPPED",
            ),
            DeliveryCard(
              id: "#0199e009",
              address: "11th street, Cairo",
              total: "28000 EGP",
              date: "10/10/2025, 7:35 AM",
              status: "SHIPPED",
            ),
          ],
        ),
      ),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  final String id;
  final String address;
  final String total;
  final String date;
  final String status;

  const DeliveryCard({
    super.key,
    required this.id,
    required this.address,
    required this.total,
    required this.date,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
          InfoRow(icon: Icons.location_on, text: address),
          InfoRow(icon: Icons.payments_outlined, text: total),
          InfoRow(icon: Icons.calendar_today, text: date),
          const SizedBox(height: 10),
          Text(
            "Status: $status",
            style: TextStyle(
              color: status == "DELIVERED" ? Colors.green : Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5748E6),
            ),
            child: const Text("Update Status"),
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
