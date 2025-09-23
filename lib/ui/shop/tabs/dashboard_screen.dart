import 'package:flutter/material.dart';

import '../../../core/color_manager.dart';
import '../widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  DashboardCard(
                    title: "مبيعات اليوم",
                    value: "2,450 EGP",
                    change: "+12%",
                  ),
                  SizedBox(width: 12),
                  DashboardCard(
                    title: "طلبات جديدة",
                    value: "24 Order",
                    change: "+4%",
                  ),
                  SizedBox(width: 12),
                  DashboardCard(
                    title: "اشعارات الرد",
                    value: "5 items",
                    change: "-2%",
                  ),
                  SizedBox(width: 12),
                  DashboardCard(
                    title: "رضا العملاء",
                    value: "92%",
                    change: "+3%",
                  ),
                ],
              ),
            ),
          ),
          // Latest Orders
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "أحدث الطلبات",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("كود الطلب")),
                        DataColumn(label: Text("العميل")),
                        DataColumn(label: Text("الإجمالي")),
                        DataColumn(label: Text("حالة الطلب")),
                        DataColumn(label: Text("تفاصيل الطلب")),
                      ],
                      rows: [
                        _buildOrderRow(
                          "#1001",
                          "Mahmoud Ali",
                          "120 EGP",
                          "Completed",
                        ),
                        _buildOrderRow(
                          "#1002",
                          "Ahmed Ashraf",
                          "85 EGP",
                          "Processing",
                        ),
                        _buildOrderRow(
                          "#1003",
                          "Youssef Ehab",
                          "230 EGP",
                          "Shipped",
                        ),
                        _buildOrderRow(
                          "#1004",
                          "Mohtar",
                          "54 EGP",
                          "Completed",
                        ),
                        _buildOrderRow(
                          "#1005",
                          "Mohamed Haytham",
                          "176 EGP",
                          "Pending",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Stock Alerts
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      "اشعارات الجرد",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildAlert("الكمية ستنتهي قريباً", "A16 شاشة سامسونج"),
                  _buildAlert("الكمية ستنتهي قريباً", "A16 شاحن سامسونج"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static DataRow _buildOrderRow(
    String code,
    String customer,
    String total,
    String status,
  ) {
    Color statusColor;
    Color bgColor;

    switch (status) {
      case "Completed":
        statusColor = Colors.green;
        bgColor = Colors.green.withOpacity(0.1);
        break;
      case "Processing":
        statusColor = Colors.blue;
        bgColor = Colors.blue.withOpacity(0.1);
        break;
      case "Shipped":
        statusColor = Colors.orange;
        bgColor = Colors.orange.withOpacity(0.1);
        break;
      case "Pending":
        statusColor = Colors.grey;
        bgColor = Colors.grey.withOpacity(0.1);
        break;
      default:
        statusColor = Colors.black;
        bgColor = Colors.black12;
    }

    return DataRow(
      cells: [
        DataCell(Text(code)),
        DataCell(Text(customer)),
        DataCell(Text(total)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const DataCell(Text("التفاصيل",
          style: TextStyle(color: ColorManager.primary, fontSize: 18),)),
      ],
    );
  }

  static Widget _buildAlert(String title, String subtitle) {
    return ListTile(
      leading: const Icon(Icons.warning, color: Colors.red),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 14)),
    );
  }
}
