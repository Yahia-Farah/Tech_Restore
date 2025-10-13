import 'package:flutter/material.dart';
import 'package:tech_restore/core/strings_manager.dart';

import '../../../../../core/color_manager.dart';
import '../../../../../core/reusable_components/CustomButton.dart';
import '../../../../auth/register/screen/register_screen.dart';

class Accounttab extends StatelessWidget {
  final List<Map<String, String>> repairHistory = [
    {
      "title": "Macbook Pro",
      "date": "March 2024",
      "image":
      "https://images.unsplash.com/photo-1517336714731-489689fd1ca8" // replace with your image
    },
    {
      "title": "Macbook Air",
      "date": "June 2019",
      "image":
      "https://images.unsplash.com/photo-1509395176047-4a66953fd231"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.profile),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, size: 60, color: Colors.grey.shade700),
            ),
            SizedBox(height: 12),

            // Name + username + location
            Text("Nada El-Said",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("@Nada2230", style: TextStyle(color: Colors.grey.shade600)),
            Text("Maadi, Cairo", style: TextStyle(color: Colors.grey.shade600)),
            SizedBox(height: 16),

            // Buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: CustomButton(
                    Textcolor: ColorManager.secondary,
                    color: ColorManager.bottons,
                    text: StringsManager.edit,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  child: CustomButton(
                    Textcolor: ColorManager.secondary,
                    color: ColorManager.primary,
                    text: StringsManager.addphoto,
                    onPressed: () {
                    },
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text("Add a photo"),
                // ),
              ],
            ),
            SizedBox(height: 20),

            // Contact info
            ListTile(
              leading: Icon(Icons.email),
              title: Text("Email: Nada2230@gmail.com"),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone: +20 1234567890"),
            ),
            Divider(height: 30),

            // Repair history
            Align(
              alignment: Alignment.centerLeft,
              child: Text(StringsManager.repair,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10),

            // History list
            Column(
              children: repairHistory.map((device) {
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      device["image"]!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(device["title"]!),
                  subtitle: Text(device["date"]!),
                );
              }).toList(),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: CustomButton(
                Textcolor: ColorManager.secondary,
                color: ColorManager.bottons,
                text: StringsManager.Signout,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
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

