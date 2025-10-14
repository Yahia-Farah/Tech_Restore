import 'package:flutter/material.dart';
import '../../../core/l10n/translation/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/dashboard_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

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
                children: [
                  DashboardCard(
                    title: local.today_sales,
                    value: "2,450 EGP",
                    change: "+12%",
                  ),
                  const SizedBox(width: 12),
                  DashboardCard(
                    title: local.new_orders,
                    value: "24 Order",
                    change: "+4%",
                  ),
                  const SizedBox(width: 12),
                  DashboardCard(
                    title: local.reply_notifications,
                    value: "5 items",
                    change: "-2%",
                  ),
                  const SizedBox(width: 12),
                  DashboardCard(
                    title: local.customer_satisfaction,
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      local.latest_orders,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text(local.order_code)),
                        DataColumn(label: Text(local.customer)),
                        DataColumn(label: Text(local.total)),
                        DataColumn(label: Text(local.order_status)),
                        DataColumn(label: Text(local.order_details)),
                      ],
                      rows: [
                        _buildOrderRow("#1001", "Mahmoud Ali", "120 EGP", local.completed),
                        _buildOrderRow("#1002", "Ahmed Ashraf", "85 EGP", local.processing),
                        _buildOrderRow("#1003", "Youssef Ehab", "230 EGP", local.shipped),
                        _buildOrderRow("#1004", "Mohtar", "54 EGP", local.completed),
                        _buildOrderRow("#1005", "Mohamed Haytham", "176 EGP", local.pending),
                        _buildOrderRow("#1005", "Mohamed Haytham", "176 EGP", local.pending),
                        _buildOrderRow("#1005", "Mohamed Haytham", "176 EGP", local.pending),
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
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      local.inventory_alerts,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildAlert(local.low_stock, local.samsung_screen),
                  _buildAlert(local.low_stock, local.samsung_charger),
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
      case "مكتمل":
        statusColor = Colors.green;
        bgColor = Colors.green.withOpacity(0.1);
        break;
      case "Processing":
      case "قيد المعالجة":
        statusColor = Colors.blue;
        bgColor = Colors.blue.withOpacity(0.1);
        break;
      case "Shipped":
      case "تم الشحن":
        statusColor = Colors.orange;
        bgColor = Colors.orange.withOpacity(0.1);
        break;
      case "Pending":
      case "قيد الانتظار":
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
        DataCell(
          Text(
            "التفاصيل",
            style: const TextStyle(color: AppColors.primary, fontSize: 18),
          ),
        ),
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
