import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/config/di.dart';
import '../../presentation/viewmodel/device_type_cubit.dart';
import '../../presentation/viewmodel/device_type_state.dart';
import '../../data/models/category_model.dart';

class DeviceTypeScreen extends StatelessWidget {
  const DeviceTypeScreen({super.key});

  // Hardcoded device list with design properties
  static final List<Map<String, dynamic>> _defaultDevices = [
    {
      "name": "Phone",
      "icon": Icons.phone_android,
      "color": Colors.blue,
      "gradient": [Colors.blue.shade400, Colors.blue.shade600],
    },
    {
      "name": "Laptop",
      "icon": Icons.laptop,
      "color": Colors.purple,
      "gradient": [Colors.purple.shade400, Colors.purple.shade600],
    },
    {
      "name": "PC",
      "icon": Icons.computer,
      "color": Colors.green,
      "gradient": [Colors.green.shade400, Colors.green.shade600],
    },
    {
      "name": "Monitor",
      "icon": Icons.monitor,
      "color": Colors.orange,
      "gradient": [Colors.orange.shade400, Colors.orange.shade600],
    },
    {
      "name": "Gaming Console",
      "icon": Icons.videogame_asset,
      "color": Colors.red,
      "gradient": [Colors.red.shade400, Colors.red.shade600],
    },
    {
      "name": "Smartwatch",
      "icon": Icons.watch,
      "color": Colors.teal,
      "gradient": [Colors.teal.shade400, Colors.teal.shade600],
    },
    {
      "name": "Tablet",
      "icon": Icons.tablet,
      "color": Colors.indigo,
      "gradient": [Colors.indigo.shade400, Colors.indigo.shade600],
    },
  ];

  // Additional colors for new categories from API
  static final List<Map<String, dynamic>> _additionalColors = [
    {
      "color": Colors.cyan,
      "gradient": [Colors.cyan.shade400, Colors.cyan.shade600],
      "icon": Icons.devices_other,
    },
    {
      "color": Colors.pink,
      "gradient": [Colors.pink.shade400, Colors.pink.shade600],
      "icon": Icons.devices,
    },
    {
      "color": Colors.amber,
      "gradient": [Colors.amber.shade400, Colors.amber.shade600],
      "icon": Icons.device_hub,
    },
    {
      "color": Colors.deepOrange,
      "gradient": [Colors.deepOrange.shade400, Colors.deepOrange.shade600],
      "icon": Icons.important_devices,
    },
    {
      "color": Colors.lime,
      "gradient": [Colors.lime.shade700, Colors.lime.shade900],
      "icon": Icons.devices_other,
    },
  ];

  static List<Map<String, dynamic>> _mergeDevices(
    List<CategoryModel> apiCategories,
  ) {
    final List<Map<String, dynamic>> mergedDevices = [];
    final Set<String> addedNames = {};

    // Only show categories from API, use hardcoded list for colors/icons
    for (int i = 0; i < apiCategories.length; i++) {
      final category = apiCategories[i];
      final normalizedName = category.name.toLowerCase().trim();

      // Skip duplicates
      if (addedNames.contains(normalizedName)) {
        continue;
      }

      // Check if this category matches any default device for icon/color
      final matchingDefault = _defaultDevices.firstWhere(
        (device) =>
            device["name"].toString().toLowerCase().trim() == normalizedName,
        orElse: () => {},
      );

      if (matchingDefault.isNotEmpty) {
        // Use the design from default device
        mergedDevices.add({
          "id": category.id,
          "name": category.name,
          "icon": matchingDefault["icon"],
          "color": matchingDefault["color"],
          "gradient": matchingDefault["gradient"],
        });
      } else {
        // Use additional colors for new categories
        final colorIndex = mergedDevices.length % _additionalColors.length;
        final colorData = _additionalColors[colorIndex];
        mergedDevices.add({
          "id": category.id,
          "name": category.name,
          "icon": colorData["icon"],
          "color": colorData["color"],
          "gradient": colorData["gradient"],
        });
      }
      addedNames.add(normalizedName);
    }

    return mergedDevices;
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => getIt<DeviceTypeCubit>()..loadCategories(),
      child: Scaffold(
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
                child: BlocBuilder<DeviceTypeCubit, DeviceTypeState>(
                  builder: (context, state) {
                    if (state is DeviceTypeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is DeviceTypeLoaded) {
                      // Show only API categories with colors/icons from hardcoded list
                      final devices = _mergeDevices(state.categories);

                      if (devices.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.devices_other,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No device categories available',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.1,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: devices.length,
                        itemBuilder: (context, index) {
                          final device = devices[index];
                          return _buildDeviceCard(context, device);
                        },
                      );
                    } else {
                      // Error or initial state - show message
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_off,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Unable to load device categories',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Please check your connection and try again',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () {
                                context
                                    .read<DeviceTypeCubit>()
                                    .loadCategories();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                              ),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, Map<String, dynamic> device) {
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
                    child: Icon(device["icon"], size: 40, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    device["name"],
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
  }
}
