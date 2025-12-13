import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/l10n/translation/app_localizations.dart';
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
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
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
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _OverviewCard(
                              title: local.total_users,
                              value: "5",
                              icon: Icons.person_outline,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _OverviewCard(
                              title: local.total_shops,
                              value: "3",
                              icon: Icons.store,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _OverviewCard(
                              title: local.repair_requests,
                              value: "0",
                              icon: Icons.build_outlined,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _OverviewCard(
                              title: local.total_orders,
                              value: "0",
                              icon: Icons.shopping_cart_outlined,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 200,
                          child: _OverviewCard(
                            title: local.total_users,
                            value: "5",
                            icon: Icons.person_outline,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 200,
                          child: _OverviewCard(
                            title: local.total_shops,
                            value: "3",
                            icon: Icons.store,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 200,
                          child: _OverviewCard(
                            title: local.repair_requests,
                            value: "0",
                            icon: Icons.build_outlined,
                          ),
                        ),
                        const SizedBox(width: 16),
                        SizedBox(
                          width: 200,
                          child: _OverviewCard(
                            title: local.total_orders,
                            value: "0",
                            icon: Icons.shopping_cart_outlined,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),

            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 600) {
                  return Column(
                    children: [
                      _SectionCard(
                        title: local.count,
                        child: const SizedBox(height: 200, child: _CountBarChart()),
                      ),
                      const SizedBox(height: 16),
                      _SectionCard(
                        title: "",
                        child: const _CountPieChart(),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _SectionCard(
                          title: local.count,
                          child: const SizedBox(height: 200, child: _CountBarChart()),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _SectionCard(
                          title: "",
                          child: const _CountPieChart(),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _OverviewCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = AppColors.primary;
    if (title.contains('Users') || title.contains('المستخدمين')) {
      iconColor = Colors.green;
    } else if (title.contains('Shops') || title.contains('المتاجر')) {
      iconColor = Colors.blue;
    } else if (title.contains('Repair') || title.contains('الإصلاح')) {
      iconColor = Colors.orange;
    } else if (title.contains('Orders') || title.contains('الطلبات')) {
      iconColor = Colors.red;
    }

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(icon, color: iconColor, size: 24),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          mainAxisSize: MainAxisSize.min,
          children: [
            if (title.isNotEmpty) ...[
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 12),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

class _CountBarChart extends StatelessWidget {
  const _CountBarChart();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 5.0,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(local.users, style: const TextStyle(fontSize: 10)),
                    );
                  case 1:
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(local.shops, style: const TextStyle(fontSize: 10)),
                    );
                  case 2:
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(local.repair_requests, style: const TextStyle(fontSize: 10)),
                    );
                  case 3:
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(local.total_orders, style: const TextStyle(fontSize: 10)),
                    );
                  default:
                    return const Text('');
                }
              },
              reservedSize: 50,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString(), style: const TextStyle(fontSize: 10));
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 0.5,
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            barRods: [
              BarChartRodData(
                toY: 5.0,
                color: Colors.green,
                width: 20,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            barRods: [
              BarChartRodData(
                toY: 3.0,
                color: Colors.blue,
                width: 20,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            barRods: [
              BarChartRodData(
                toY: 0.0,
                color: Colors.orange,
                width: 20,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            barRods: [
              BarChartRodData(
                toY: 0.0,
                color: Colors.red,
                width: 20,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountPieChart extends StatelessWidget {
  const _CountPieChart();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 8,
            children: [
              _LegendItem(color: Colors.green, label: local.users),
              _LegendItem(color: Colors.blue, label: local.shops),
              _LegendItem(color: Colors.orange, label: local.repair_requests),
              _LegendItem(color: Colors.red, label: local.total_orders),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 5,
                    color: Colors.green,
                    title: "",
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 3,
                    color: Colors.blue,
                    title: "",
                    radius: 50,
                  ),
                ],
                sectionsSpace: 2,
                centerSpaceRadius: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

