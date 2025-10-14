import 'package:flutter/material.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_elevated_button.dart';
import '../../../../auth/register/screen/register_screen.dart';

class Accounttab extends StatelessWidget {
  final List<Map<String, String>> repairHistory = [
    {
      "title": "Macbook Pro",
      "date": "March 2024",
      "image":
      "https://images.unsplash.com/photo-1517336714731-489689fd1ca8",
    },
    {
      "title": "Macbook Air",
      "date": "June 2019",
      "image":
      "https://images.unsplash.com/photo-1509395176047-4a66953fd231",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.profile),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Profile picture
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.person, size: 60, color: Colors.grey.shade700),
            ),
            const SizedBox(height: 12),

            /// Name + username + location (these are placeholder user values)
            const Text(
              "Nada El-Said",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "@Nada2230",
              style: TextStyle(color: Colors.grey),
            ),
            const Text(
              "Maadi, Cairo",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  width: 180,
                  height: 50,
                  textColor: AppColors.black,
                  color: AppColors.buttons,
                  text: local.editProfile,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                ),
                const SizedBox(width: 10),

                CustomElevatedButton(
                  width: 180,
                  height: 50,
                  textColor: AppColors.white,
                  color: AppColors.primary,
                  text: local.addPhoto,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.email),
              title: Text("${local.email}: Nada2230@gmail.com"),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text("${local.phone}: +20 1234567890"),
            ),
            const Divider(height: 30),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                local.repair,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

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
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: CustomElevatedButton(

                textColor: AppColors.secondary,
                color: AppColors.buttons,
                text: local.signOut,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
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
