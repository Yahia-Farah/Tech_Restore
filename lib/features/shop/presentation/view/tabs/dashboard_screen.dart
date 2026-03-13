import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import '../../../../../core/l10n/translation/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/config/di.dart';
import '../../../data/repositories/shop_repository.dart';
import '../../viewmodel/dashboard_cubit.dart';
import '../../viewmodel/dashboard_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              DashboardCubit(getIt<ShopRepository>())..loadDashboardData(),
      child: const DashboardScreenContent(),
    );
  }
}

class DashboardScreenContent extends StatefulWidget {
  const DashboardScreenContent({super.key});

  @override
  State<DashboardScreenContent> createState() => _DashboardScreenContentState();
}

class _DashboardScreenContentState extends State<DashboardScreenContent>
    with SingleTickerProviderStateMixin {
  DateTime? _startDate;
  DateTime? _endDate;
  late ScrollController _scrollController;
  Timer? _scrollTimer;
  bool _isScrollingRight = true;
  bool _isUserScrolling = false;

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

  Future<void> _selectDateTime(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          isStartDate
              ? (_startDate ?? DateTime.now())
              : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 0, minute: 0),
      );

      if (pickedTime != null && mounted) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          if (isStartDate) {
            _startDate = selectedDateTime;
          } else {
            _endDate = selectedDateTime;
          }
        });
      }
    }
  }

  String _formatDateTime(DateTime? date, AppLocalizations local) {
    if (date == null) return 'dd/mm/yyyy HH:mm';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _startAutoScroll();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.isScrollingNotifier.value) {
      if (!_isUserScrolling) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      }
    } else {
      if (_isUserScrolling) {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 2), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollTimer?.cancel();
    super.dispose();
  }

  void _startAutoScroll() {
    _scrollTimer?.cancel();
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!_scrollController.hasClients || _isUserScrolling) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;

      if (maxScroll <= 0) return; // No scrolling needed if content fits

      double targetScroll;
      if (_isScrollingRight) {
        if (currentScroll >= maxScroll) {
          _isScrollingRight = false;
          targetScroll = currentScroll - 1.0;
        } else {
          targetScroll = currentScroll + 1.0;
        }
      } else {
        if (currentScroll <= 0) {
          _isScrollingRight = true;
          targetScroll = currentScroll + 1.0;
        } else {
          targetScroll = currentScroll - 1.0;
        }
      }

      _scrollController.jumpTo(targetScroll.clamp(0.0, maxScroll));
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);
    final isRTL = locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh:
                () => context.read<DashboardCubit>().refreshDashboard(
                  startDate: _startDate,
                  endDate: _endDate,
                ),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(local, isRTL),
                    const SizedBox(height: 24),
                    _buildDateFilter(local, isRTL),
                    const SizedBox(height: 24),
                    if (state is DashboardLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (state is DashboardError)
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed:
                                    () => context
                                        .read<DashboardCubit>()
                                        .loadDashboardData(
                                          startDate: _startDate,
                                          endDate: _endDate,
                                        ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      )
                    else if (state is DashboardLoaded) ...[
                      _buildKPICards(local, isRTL, state),
                      const SizedBox(height: 24),
                      _buildCharts(local, isRTL, state),
                    ] else
                      _buildKPICards(local, isRTL, null),
                  ],
                ),
              ),
            ),
          );
        },
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
              crossAxisAlignment:
                  isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                  style: TextStyle(fontSize: 14, color: Colors.black54),
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
    return Column(
      children: [
        Row(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Expanded(
              child: _buildDateField(
                label: local.endDate,
                date: _endDate,
                onTap: () => _selectDateTime(context, false),
                isRTL: isRTL,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildDateField(
                label: local.startDate,
                date: _startDate,
                onTap: () => _selectDateTime(context, true),
                isRTL: isRTL,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (_startDate != null && _endDate != null) {
                        context.read<DashboardCubit>().loadDashboardData(
                          startDate: _startDate,
                          endDate: _endDate,
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Apply',
                        textAlign: TextAlign.center,
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
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
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
                      context.read<DashboardCubit>().loadDashboardData();
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        local.reset,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black87,
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
                    _formatDateTime(date, local),
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

  Widget _buildKPICards(
    AppLocalizations local,
    bool isRTL,
    DashboardLoaded? state,
  ) {
    final currency = _getCurrency(local);
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 24) / 3;

    return GestureDetector(
      onPanStart: (_) {
        _isUserScrolling = true;
        _scrollTimer?.cancel();
      },
      onPanEnd: (_) {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 2), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      },
      onPanCancel: () {
        _isUserScrolling = false;
        Future.delayed(const Duration(seconds: 2), () {
          if (!_isUserScrolling && mounted && _scrollController.hasClients) {
            _startAutoScroll();
          }
        });
      },
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Row(
          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
          children: [
            SizedBox(
              width: cardWidth,
              height: 130,
              child: _buildKPICard(
                title: local.totalSales,
                value: '${state?.totalSales ?? 0} $currency',
                isRTL: isRTL,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: cardWidth,
              height: 130,
              child: _buildKPICard(
                title: local.todaysSales,
                value: '${state?.salesStats.totalSales ?? 0} $currency',
                secondaryValue:
                    '$currency ${local.yesterday}: ${state?.salesStats.previousDaySales ?? 0}',
                isRTL: isRTL,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: cardWidth,
              height: 130,
              child: _buildKPICard(
                title: local.totalOrders,
                value: '${state?.totalOrders ?? 0}',
                isRTL: isRTL,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: cardWidth,
              height: 130,
              child: _buildKPICard(
                title: local.todaysRepairs,
                value: '${state?.repairsStats.totalSales ?? 0}',
                secondaryValue:
                    '${local.yesterday}: ${state?.repairsStats.previousDaySales ?? 0}',
                isRTL: isRTL,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: cardWidth,
              height: 130,
              child: _buildKPICard(
                title: local.totalRepairRequests,
                value: '${state?.totalRepairs ?? 0}',
                isRTL: isRTL,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required bool isRTL,
    String? secondaryValue,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(left: BorderSide(color: AppColors.primary, width: 4)),
      ),
      child: Column(
        crossAxisAlignment:
            isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isRTL ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: isRTL ? TextAlign.right : TextAlign.left,
                  maxLines: 1,
                ),
                if (secondaryValue != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    secondaryValue,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    textAlign: isRTL ? TextAlign.right : TextAlign.left,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharts(
    AppLocalizations local,
    bool isRTL,
    DashboardLoaded state,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    if (isSmallScreen) {
      return Column(
        children: [
          _buildSalesChart(local, isRTL, state),
          const SizedBox(height: 12),
          _buildRepairsChart(local, isRTL, state),
        ],
      );
    }

    return Row(
      textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
      children: [
        Expanded(child: _buildSalesChart(local, isRTL, state)),
        const SizedBox(width: 12),
        Expanded(child: _buildRepairsChart(local, isRTL, state)),
      ],
    );
  }

  Widget _buildSalesChart(
    AppLocalizations local,
    bool isRTL,
    DashboardLoaded state,
  ) {
    // Use real data from API
    final chartData = state.salesChartData;

    if (chartData.isEmpty) {
      return Card(
        color: AppColors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                local.salesTrendWeekly,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              const Text('No data available'),
            ],
          ),
        ),
      );
    }

    final maxSalesValue = chartData
        .map((e) => e.totalSales)
        .reduce((a, b) => a > b ? a : b);
    final chartMaxY =
        maxSalesValue > 0
            ? ((maxSalesValue / 1000).ceil() * 1000).toDouble()
            : 100.0;

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
                                value.toInt() < chartData.length) {
                              // Calculate day index (0=Sunday, 6=Saturday)
                              final now = DateTime.now();
                              final daysAgo = 3 - value.toInt();
                              final date = now.subtract(
                                Duration(days: daysAgo),
                              );
                              final dayIndex = date.weekday % 7;
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
                            chartData.asMap().entries.map((entry) {
                              return FlSpot(
                                entry.key.toDouble(),
                                entry.value.totalSales.toDouble(),
                              );
                            }).toList(),
                        isCurved: true,
                        color: const Color(0xFF8DC63F),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF8DC63F).withValues(alpha: 0.2),
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

  Widget _buildRepairsChart(
    AppLocalizations local,
    bool isRTL,
    DashboardLoaded state,
  ) {
    // Use real data from API
    final chartData = state.repairsChartData;

    if (chartData.isEmpty) {
      return Card(
        color: AppColors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                local.repairsTrendWeekly,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              const Text('No data available'),
            ],
          ),
        ),
      );
    }

    final maxRepairsValue = chartData
        .map((e) => e.totalSales)
        .reduce((a, b) => a > b ? a : b);
    final chartMaxY =
        maxRepairsValue > 0
            ? ((maxRepairsValue / 5).ceil() * 5).toDouble()
            : 10.0;

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
                                value.toInt() < chartData.length) {
                              // Calculate day index (0=Sunday, 6=Saturday)
                              final now = DateTime.now();
                              final daysAgo = 3 - value.toInt();
                              final date = now.subtract(
                                Duration(days: daysAgo),
                              );
                              final dayIndex = date.weekday % 7;
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
                        chartData.asMap().entries.map((entry) {
                          return BarChartGroupData(
                            x: entry.key,
                            barRods: [
                              BarChartRodData(
                                toY: entry.value.totalSales.toDouble(),
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
                    color: const Color(0xFF2EC4B6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  local.totalRepairRequests,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
