// import 'package:flutter/material.dart';
// import 'package:tech_restore/core/strings_manager.dart';
//
// class DeviceIssueScreen extends StatefulWidget {
//   @override
//   _DeviceIssueScreenState createState() => _DeviceIssueScreenState();
// }
//
// class _DeviceIssueScreenState extends State<DeviceIssueScreen> {
//   String? selectedIssue;
//
//   final List<Map<String, String>> issues = [
//     {"title": "Cracked Screen", "subtitle": "Display is broken or damaged"},
//     {"title": "Battery Replacement", "subtitle": "Battery won’t hold a charge"},
//     {"title": "Charging Port Issue", "subtitle": "Device won’t charge"},
//     {"title": "Other", "subtitle": "Something else"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(StringsManager.deviceissue),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {},
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               StringsManager.deviceIssuequote,
//               style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//             ),
//           ),
//           Expanded(
//             child: ListView(
//               children: issues.map((issue) {
//                 return RadioListTile<String>(
//                   value: issue["title"]!,
//                   groupValue: selectedIssue,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedIssue = value;
//                     });
//                   },
//                   title: Text(issue["title"]!,
//                       style: TextStyle(fontWeight: FontWeight.w500)),
//                   subtitle: Text(issue["subtitle"]!),
//                 );
//               }).toList(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: EdgeInsets.symmetric(vertical: 14),
//                   backgroundColor: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 onPressed: selectedIssue == null ? null : () {
//                   // Next action
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Selected: $selectedIssue")),
//                   );
//                 },
//                 child: Text(
//                   "Next",
//                   style: TextStyle(fontSize: 16, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
//
// class DeviceIssueScreen extends StatefulWidget {
//   @override
//   _DeviceIssuePageState createState() => _DeviceIssuePageState();
// }
//
// class _DeviceIssuePageState extends State<DeviceIssueScreen> {
//   String? selectedIssue;
//
//   final issues = [
//     {"title": "Cracked Screen", "subtitle": "Display is broken or damaged"},
//     {"title": "Battery Replacement", "subtitle": "Battery won’t hold a charge"},
//     {"title": "Charging Port Issue", "subtitle": "Device won’t charge"},
//     {"title": "Other", "subtitle": "Something else"},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Device issue"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               children: issues.map((issue) {
//                 return RadioListTile<String>(
//                   title: Text(issue["title"]!),
//                   subtitle: Text(issue["subtitle"]!),
//                   value: issue["title"]!,
//                   groupValue: selectedIssue,
//                   onChanged: (value) {
//                     setState(() {
//                       selectedIssue = value;
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: ElevatedButton(
//               onPressed: selectedIssue != null ? () {} : null,
//               child: Text("Next"),
//               style: ElevatedButton.styleFrom(
//                 minimumSize: Size(double.infinity, 50),
//                 backgroundColor: Colors.blue,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

import 'issue_description_page.dart';


class DeviceIssueScreen extends StatefulWidget {
  @override
  _DeviceIssuePageState createState() => _DeviceIssuePageState();
}

class _DeviceIssuePageState extends State<DeviceIssueScreen> {
  String? selectedIssue;

  final issues = [
    {"title": "Cracked Screen", "subtitle": "Display is broken or damaged"},
    {"title": "Battery Replacement", "subtitle": "Battery won’t hold a charge"},
    {"title": "Charging Port Issue", "subtitle": "Device won’t charge"},
    {"title": "Other", "subtitle": "Something else"},
  ];

  void _onNextPressed() {
    if (selectedIssue == "Other") {
      // Navigate to Issue Description screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IssueDescriptionPage()),
      );
    } else {
      // Handle other issues (e.g. show a message or next step)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Selected: $selectedIssue")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device issue"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: issues.map((issue) {
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
              child: Text("Next"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
