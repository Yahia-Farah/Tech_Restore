import 'package:flutter/material.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/route_names.dart';

class CreateOrder extends StatelessWidget {
  const CreateOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> devices = [
      {"icon": Icons.phone_android, "label": "Phone"},
      {"icon": Icons.laptop, "label": "Laptop"},
      {"icon": Icons.computer, "label": "PC"},
      {"icon": Icons.monitor, "label": "Monitor"},
      {"icon": Icons.videogame_asset, "label": "Gaming console"},
      {"icon": Icons.watch, "label": "Smartwatch"},
      {"icon": Icons.tablet, "label": "Tablet"},
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(local.whatRepair),
        titleTextStyle: const TextStyle(
          color: AppColors.secondary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  childAspectRatio: 3, // adjust size ratio
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.deviceIssue);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(devices[index]["icon"], size: 28),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              devices[index]["label"],
                              style: const TextStyle(fontSize: 16),
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
