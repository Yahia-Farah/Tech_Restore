import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/l10n/translation/app_localizations.dart';

class AdminAssignmentLogsScreen extends StatefulWidget {
  const AdminAssignmentLogsScreen({super.key});

  @override
  State<AdminAssignmentLogsScreen> createState() =>
      _AdminAssignmentLogsScreenState();
}

class _AdminAssignmentLogsScreenState extends State<AdminAssignmentLogsScreen> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.black[30]!, width: 1),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.assignment_turned_in_outlined,
                          color: AppColors.primary[70],
                          size: 28,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          local.assignment_logs,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary[70],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      local.track_all_assignment_activities,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black[40],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              color: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppColors.black[30]!, width: 1),
              ),
              elevation: 0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.assignment_turned_in_outlined,
                      size: 80,
                      color: AppColors.primary[70],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      local.no_assignment_logs_found,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      local.no_assignment_logs_description,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black[40],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


