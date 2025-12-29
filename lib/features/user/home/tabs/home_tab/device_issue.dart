import 'package:flutter/material.dart';
import '../../../../../core/routes/route_names.dart';

class DeviceIssueScreen extends StatefulWidget {
  const DeviceIssueScreen({super.key});

  @override
  _DeviceIssueScreenState createState() => _DeviceIssueScreenState();
}

class _DeviceIssueScreenState extends State<DeviceIssueScreen> {
  String? selectedIssue;

  final issues = [
    {"title": "Cracked Screen", "subtitle": "Display is broken or damaged"},
    {"title": "Battery Replacement", "subtitle": "Battery won't hold a charge"},
    {"title": "Charging Port Issue", "subtitle": "Device won't charge"},
    {"title": "Other", "subtitle": "Something else"},
  ];

  void _onNextPressed() {
    if (selectedIssue == "Other") {
      // Navigate to Issue Description screen
      Navigator.pushNamed(context, AppRoutes.issueDescription);
    } else {
      // Handle other issues (e.g. show a message or next step)
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Selected: $selectedIssue")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device issue"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children:
                  issues.map((issue) {
                    return RadioListTile<String>(
                      title: Text(issue["title"]!),
                      subtitle: Text(issue["subtitle"]!),
                      value: issue["title"]!,
                      groupValue: selectedIssue,
                      onChanged: (value) {
                        setState(() {
                          selectedIssue = value;
                        });
                      },
                    );
                  }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: selectedIssue != null ? _onNextPressed : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Next",style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
