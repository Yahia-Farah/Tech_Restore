import 'package:flutter/material.dart';

import '../../../../../core/color_manager.dart';
import '../../../../../core/reusable_components/CustomButton.dart';
import '../../../../../core/strings_manager.dart';
import '../../screen/home_screen.dart';

class Tracktab extends StatelessWidget {
  late final String trackingNumber;


  final List<Map<String, String>> statusUpdates = [
    {"status": "Order received", "date": "Jan 21", "icon": "box"},
    {"status": "Technician assigned", "date": "Jan 23", "icon": "build"},
    {"status": "Diagnosing issue", "date": "Jan 24", "icon": "search"},
    {"status": "Repair in progress", "date": "Jan 25", "icon": "handyman"},
  ];

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case "box":
        return Icons.local_shipping;
      case "build":
        return Icons.build;
      case "search":
        return Icons.search;
      case "handyman":
        return Icons.handyman;
      default:
        return Icons.circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringsManager.repairstatue)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringsManager.trackingnumber,
                style: TextStyle(fontSize: 16, color: Colors.black)),
            SizedBox(height: 15,),
            Text("#1077",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(StringsManager.livestu,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: statusUpdates.length,
                itemBuilder: (context, index) {
                  var item = statusUpdates[index];
                  return ListTile(
                    leading: Icon(_getIcon(item["icon"]!),
                        color: Colors.blue, size: 30),
                    title: Text(item["status"]!),
                    subtitle: Text(item["date"]!),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            Center(
              child:Container(
                width: double.infinity,
                child: CustomButton(
                  Textcolor: ColorManager.background,
                  color: ColorManager.primary,
                  text: StringsManager.home,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}

