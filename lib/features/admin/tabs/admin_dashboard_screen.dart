import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/theme/app_colors.dart';
import '../widgets/admin_drawer.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AdminDrawerWidget(
        onItemTapped: _onItemTapped,
        selectedIndex: _selectedIndex,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 150, // set fixed height for horizontal cards
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _OverviewCard(
                    title: "Total Users",
                    value: "10,864",
                    change: "+12% from last month",
                    icon: Icons.person_outline,
                  ),
                  SizedBox(width: 16),
                  _OverviewCard(
                    title: "Active Repair Shops",
                    value: "187",
                    change: "+8% from last month",
                    icon: Icons.build_outlined,
                  ),
                  SizedBox(width: 16),
                  _OverviewCard(
                    title: "Monthly Revenue",
                    value: "12,000 EGP",
                    change: "+5% from last month",
                    icon: Icons.attach_money,
                  ),
                  SizedBox(width: 16),
                  _OverviewCard(
                    title: "Pending Reviews",
                    value: "23",
                    change: "+24% from last month",
                    icon: Icons.rate_review_outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            const _SectionCard(
              title: "Latest Activities",
              child: Column(
                children: [
                  _ActivityTile(
                    icon: Icons.store_mall_directory,
                    text: "New repair shop 'TechFix Pro' pending approval",
                    time: "2 hours ago",
                    color: AppColors.primary,
                  ),
                  _ActivityTile(
                    icon: Icons.report_problem_outlined,
                    text: "Abusive review reported for 'Mobile Masters'",
                    time: "4 hours ago",
                    color: Colors.red,
                  ),
                  _ActivityTile(
                    icon: Icons.attach_money,
                    text: "High-value transaction flagged for review",
                    time: "6 hours ago",
                    color: Colors.green,
                  ),
                  _ActivityTile(
                    icon: Icons.warning_amber_rounded,
                    text: "Customer complaint about delayed delivery",
                    time: "8 hours ago",
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ====== Charts Side by Side (keep same) ======
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: _SectionCard(
                    title: "Revenue Overview",
                    child: SizedBox(height: 200, child: _RevenueChart()),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _SectionCard(
                    title: "Device Categories",
                    child: SizedBox(height: 200, child: _DevicePieChart()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Overview Card =====
class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final String change;
  final IconData icon;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              change,
              style: const TextStyle(color: Colors.green, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Section Card =====
class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// ===== Activity Tile =====
class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;
  final Color color;

  const _ActivityTile({
    required this.icon,
    required this.text,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: color),
      title: Text(text),
      subtitle: Text(time, style: const TextStyle(fontSize: 12)),
    );
  }
}

// ===== Revenue Chart =====
class _RevenueChart extends StatelessWidget {
  const _RevenueChart();

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 6000),
              FlSpot(1, 5500),
              FlSpot(2, 8000),
              FlSpot(3, 9000),
              FlSpot(4, 7000),
              FlSpot(5, 12000),
            ],
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}

// ===== Device Pie Chart =====
class _DevicePieChart extends StatelessWidget {
  const _DevicePieChart();

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 50,
            color: Colors.blue,
            title: "Smartphones",
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          PieChartSectionData(
            value: 20,
            color: Colors.green,
            title: "Tablets",
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          PieChartSectionData(
            value: 15,
            color: Colors.orange,
            title: "Laptops",
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          PieChartSectionData(
            value: 15,
            color: Colors.purple,
            title: "Accessories",
            radius: 40,
            titleStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
