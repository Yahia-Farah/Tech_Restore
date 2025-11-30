import 'package:flutter/material.dart';

class Exploretab extends StatelessWidget {
  final List<Map<String, dynamic>> devices = [
    {
      "name": "MacBook Pro 14”",
      "category": "Laptop",
      "price": "1,999 EGP",
      "status": "New",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/5/5e/MacBook_Pro_14_inch.png",
    },
    {
      "name": "iPhone 13 Pro",
      "category": "Phone",
      "price": "999 EGP",
      "status": "New",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/f/f1/IPhone_13_Pro.png",
    },
    {
      "name": "iPad Air",
      "category": "Tablet",
      "price": "450 EGP",
      "status": "Used",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/f/fa/IPad_Air.png",
    },
    {
      "name": "PlayStation 5",
      "category": "Console",
      "price": "499 EGP",
      "status": "Used",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/0/05/PlayStation_5_console.png",
    },
  ];

  Exploretab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Explore Devices",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔍 Filter Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search devices or shops...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DropdownButton<String>(
                            hint: Text("All Categories"),
                            items:
                                ["Laptop", "Phone", "Tablet", "Console"]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {},
                          ),
                          DropdownButton<String>(
                            hint: Text("All Conditions"),
                            items:
                                ["New", "Used"]
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // 🖥 Device Grid
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: devices.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  var device = devices[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            device["image"],
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                device["name"],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                device["category"],
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                device["price"],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text("Buy Now"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),

              // 🔵 Why Choose Us Section
              Text(
                "Why Choose Our Platform?",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _infoCard(
                    Icons.verified,
                    "Verified Shops",
                    "Strict verification for quality assurance",
                  ),
                  _infoCard(
                    Icons.star,
                    "Customer Ratings",
                    "Real reviews from satisfied customers",
                  ),
                  _infoCard(
                    Icons.flash_on,
                    "Fast Service",
                    "Quick repairs with guaranteed times",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Card(
        color: Colors.blue.shade50,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Icon(icon, color: Colors.blue),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
