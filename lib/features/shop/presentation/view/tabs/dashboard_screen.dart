import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DateTime? _startDate;
  DateTime? _endDate;

  // Sample data for charts
  final List<SalesData> _salesData = [
    SalesData(day: 0, value: 2500),
    SalesData(day: 1, value: 1500),
    SalesData(day: 2, value: 10000),
    SalesData(day: 3, value: 4000),
    SalesData(day: 4, value: 5000),
    SalesData(day: 5, value: 3800),
    SalesData(day: 6, value: 4200),
  ];

  final List<RepairData> _repairData = [
    RepairData(day: 0, value: 11),
    RepairData(day: 1, value: 19),
    RepairData(day: 2, value: 15),
    RepairData(day: 3, value: 22),
    RepairData(day: 4, value: 18),
    RepairData(day: 5, value: 14),
    RepairData(day: 6, value: 20),
  ];

  String _getCurrency(AppLocalizations local) {
    final locale = Localizations.localeOf(context);
    return locale.languageCode == 'ar' ? 'ج.م' : 'EGP';
  }

  String _getDayName(int dayIndex, AppLocalizations local) {
    switch (dayIndex) {
      case 0:
        return local.sunday;
      case 1:
        return local.monday;
      case 2:
        return local.tuesday;
      case 3:
        return local.wednesday;
      case 4:
        return local.thursday;
      case 5:
        return local.friday;
      case 6:
        return local.saturday;
      default:
        return '';
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          isStartDate
              ? (_startDate ?? DateTime.now())
              : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date, AppLocalizations local) {
    if (date == null) return 'dd/mm/yyyy --:--';
    final locale = Localizations.localeOf(context);
    if (locale.languageCode == 'ar') {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} --:--';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} --:--';
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(local, isRTL),
              const SizedBox(height: 24),
              _buildDateFilter(local, isRTL),
              const SizedBox(height: 24),
              _buildKPICards(local, isRTL),
              const SizedBox(height: 24),
              _buildCharts(local, isRTL),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations local, bool isRTL) {
    return Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              crossAxisAlignment: isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  local.dashboardTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  local.dashboardSubtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateFilter(AppLocalizations local, bool isRTL) {
    return Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(
          child: _buildDateField(
            label: local.endDate,
            date: _endDate,
            onTap: () => _selectDate(context, false),
            isRTL: isRTL,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildDateField(
            label: local.startDate,
            date: _startDate,
            onTap: () => _selectDate(context, true),
            isRTL: isRTL,
          ),
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _startDate = null;
                    _endDate = null;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  child: Text(
                    local.reset,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    required bool isRTL,
  }) {
    final local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment:
          isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Expanded(
                  child: Text(
                    _formatDate(date, local),
                    style: TextStyle(
                      fontSize: 14,
                      color: date == null ? Colors.grey[400] : Colors.black87,
                    ),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  ),
                ),
                Icon(Icons.calendar_today, color: Colors.grey[600], size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildKPICards(AppLocalizations local, bool isRTL) {
    final currency = _getCurrency(local);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth =
        (screenWidth - 48 - 24) / 3; // 3 cards with 2 gaps of 12px each

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
        children: [
          _buildKPICard(
            title: local.totalSales,
            value: '0 $currency',
            isRTL: isRTL,
          ),
          const SizedBox(width: 12),
          _buildKPICard(
            title: local.totalOrders,
            value: '0',
            isRTL: isRTL,
          ),
          const SizedBox(width: 12),
          _buildKPICard(
            title: local.totalRepairRequests,
            value: '0',
            isRTL: isRTL,
          ),
        ],
      ),
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required bool isRTL,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: AppColors.primary, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
            textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),

            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildCharts(AppLocalizations local, bool isRTL) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    if (isSmallScreen) {
      return Column(
        children: [
          _buildSalesChart(local, isRTL),
          const SizedBox(height: 12),
          _buildRepairsChart(local, isRTL),
        ],
      );
    }

    return Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(child: _buildSalesChart(local, isRTL)),
        const SizedBox(width: 12),
        Expanded(child: _buildRepairsChart(local, isRTL)),
      ],
    );
  }

  Widget _buildSalesChart(AppLocalizations local, bool isRTL) {
    final last4DaysSales = _salesData.sublist(_salesData.length - 4);
    final maxSalesValue = last4DaysSales
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);
    final chartMaxY = ((maxSalesValue / 1000).ceil() * 1000).toDouble();

    return Card(
      color: AppColors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              local.salesTrendWeekly,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: chartMaxY / 5,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          interval: chartMaxY / 5,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < last4DaysSales.length) {
                            final dayIndex = last4DaysSales[value.toInt()].day;
                            final dayName = _getDayName(dayIndex, local);
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                dayName,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots:
                          last4DaysSales.asMap().entries.map((entry) {
                            return FlSpot(
                              entry.key.toDouble(),
                              entry.value.value.toDouble(),
                            );
                          }).toList(),
                      isCurved: true,
                      color: const Color(0xFF8DC63F),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: const Color(0xFF8DC63F).withOpacity(0.2),
                      ),
                    ),
                  ],
                  minY: 0,
                  maxY: chartMaxY,
                ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment:
                  isRTL ? MainAxisAlignment.start : MainAxisAlignment.end,
              textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8DC63F),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${local.sales} (${_getCurrency(local)})',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRepairsChart(AppLocalizations local, bool isRTL) {
    final last4DaysRepairs = _repairData.sublist(_repairData.length - 4);
    final maxRepairsValue = last4DaysRepairs
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);
    final chartMaxY = ((maxRepairsValue / 5).ceil() * 5).toDouble();

    return Card(
      color: AppColors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment:
              isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              local.repairsTrendWeekly,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: chartMaxY / 5,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          interval: chartMaxY / 5,
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 10,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 &&
                              value.toInt() < last4DaysRepairs.length) {
                            final dayIndex =
                                last4DaysRepairs[value.toInt()].day;
                            final dayName = _getDayName(dayIndex, local);
                            return Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                dayName,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups:
                      last4DaysRepairs.asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.value.toDouble(),
                              color: const Color(0xFF2EC4B6),
                              width: 20,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                  minY: 0,
                  maxY: chartMaxY,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  final int day;
  final int value;

  SalesData({required this.day, required this.value});
}

class RepairData {
  final int day;
  final int value;

  RepairData({required this.day, required this.value});
}
