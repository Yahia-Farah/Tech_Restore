import 'package:flutter/material.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/route_names.dart';

class DeviceTypeScreen extends StatelessWidget {
  const DeviceTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> devices = [
      {
        "icon": Icons.phone_android,
        "label": "Phone",
        "color": Colors.blue,
        "gradient": [Colors.blue.shade400, Colors.blue.shade600],
      },
      {
        "icon": Icons.laptop,
        "label": "Laptop",
        "color": Colors.purple,
        "gradient": [Colors.purple.shade400, Colors.purple.shade600],
      },
      {
        "icon": Icons.computer,
        "label": "PC",
        "color": Colors.green,
        "gradient": [Colors.green.shade400, Colors.green.shade600],
      },
      {
        "icon": Icons.monitor,
        "label": "Monitor",
        "color": Colors.orange,
        "gradient": [Colors.orange.shade400, Colors.orange.shade600],
      },
      {
        "icon": Icons.videogame_asset,
        "label": "Gaming Console",
        "color": Colors.red,
        "gradient": [Colors.red.shade400, Colors.red.shade600],
      },
      {
        "icon": Icons.watch,
        "label": "Smartwatch",
        "color": Colors.teal,
        "gradient": [Colors.teal.shade400, Colors.teal.shade600],
      },
      {
        "icon": Icons.tablet,
        "label": "Tablet",
        "color": Colors.indigo,
        "gradient": [Colors.indigo.shade400, Colors.indigo.shade600],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          local.whatRepair,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Select your device type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the device you need to repair',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.deviceIssue);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: device["gradient"],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: device["color"].withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.deviceIssue);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    device["icon"],
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  device["label"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
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
