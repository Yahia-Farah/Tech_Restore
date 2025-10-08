import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;

  const DashboardCard(
      {super.key,
        required this.title,
        required this.value,
        required this.change});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Text(value,
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Text(change,
                style: TextStyle(
                    fontSize: 12,
                    color: change.startsWith("+")
                        ? Colors.green
                        : Colors.red)),
          ],
        ),
      ),
    );
  }
}