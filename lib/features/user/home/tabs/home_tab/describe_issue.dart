import 'package:flutter/material.dart';
import 'package:tech_restore/core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';

class IssueDescriptionScreen extends StatefulWidget {
  static const String routeName = "issueDescription";

  const IssueDescriptionScreen({super.key});

  @override
  _IssueDescriptionScreenState createState() => _IssueDescriptionScreenState();
}

class _IssueDescriptionScreenState extends State<IssueDescriptionScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(local.deviceIssue),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              local.cancel,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Text field
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: local.describeIssue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Upload placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(local.uploadPorV),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    // Upload logic
                  },
                ),
              ],
            ),

            const Spacer(),

            /// Next button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle next
                },
                child: Text(
                  local.next,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),

      /// Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: local.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.search),
            label: local.explore,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.local_shipping),
            label: local.trackingNumber,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: local.profile,
          ),
        ],
      ),
    );
  }
}
