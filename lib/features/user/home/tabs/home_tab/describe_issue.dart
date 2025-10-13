import 'package:flutter/material.dart';
import 'package:tech_restore/core/strings_manager.dart';

class IssueDescriptionScreen extends StatefulWidget {
  static const String routename = "issuedescription";
  @override
  _IssueDescriptionScreenState createState() => _IssueDescriptionScreenState();
}

class _IssueDescriptionScreenState extends State<IssueDescriptionScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text field
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: StringsManager.describeissue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Upload placeholder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(StringsManager.uploadporv),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 18),
                  onPressed: () {
                    // Upload logic
                  },
                ),
              ],
            ),
            Spacer(),

            // Next button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // Handle next
                },
                child: Text("Next", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: "Track"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}