// import 'package:flutter/material.dart';
// import 'package:tech_restore/core/strings_manager.dart';
//
// import '../../../../core/color_manager.dart';
//
// class Createorder extends StatelessWidget {
//   const Createorder({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(StringsManager.whatrepair),
//           titleTextStyle: TextStyle(
//               color: ColorManager.secondary,
//               fontSize: 22,
//               fontWeight: FontWeight.w700
//           )),
//
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:tech_restore/ui/home/tabs/home_tab/device_issue.dart';

import '../../../../core/color_manager.dart';
import '../../../../core/strings_manager.dart';

class Createorder extends StatelessWidget {
  final List<Map<String, dynamic>> devices = [
    {"icon": Icons.phone_android, "label": "Phone"},
    {"icon": Icons.laptop, "label": "Laptop"},
    {"icon": Icons.computer, "label": "PC"},
    {"icon": Icons.monitor, "label": "Monitor"},
    {"icon": Icons.videogame_asset, "label": "Gaming console"},
    {"icon": Icons.watch, "label": "Smartwatch"},
    {"icon": Icons.tablet, "label": "Tablet"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
           title: Text(StringsManager.whatrepair),
           titleTextStyle: TextStyle(
               color: ColorManager.secondary,
               fontSize: 22,
               fontWeight: FontWeight.w700
           )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,      // 2 items per row
                  childAspectRatio: 3,    // adjust size ratio
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => DeviceIssueScreen()),
                      );
                      // Handle click
                      //print("Selected: ${devices[index]['label']}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(devices[index]["icon"], size: 28),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              devices[index]["label"],
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

