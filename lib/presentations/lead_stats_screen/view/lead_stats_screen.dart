import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../repository/api/lead_stats_screen/model/lead_stats_model.dart';
import '../../../repository/api/lead_stats_screen/service/lead_stats_service.dart';
import '../controller/lead_stats_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sw_crm/core/constants/color_extensions.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/textstyles.dart';

class LeadChart extends StatelessWidget {
  const LeadChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LeadStatsController(LeadStatsService())..loadLeadStats(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Lead Statistics',
            style: GLTextStyles.robotoStyle(size: 22, weight: FontWeight.w500),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            color: Colors.white,
            elevation: 0.8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Consumer<LeadStatsController>(
              builder: (context, controller, child) {
                if (controller.isLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage != null) {
                  return Center(child: Text('Error: ${controller.errorMessage}'));
                } else if (controller.leadStats == null || controller.leadStats!.isEmpty) {
                  return Center(child: Text('No data available'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: AspectRatio(
                      aspectRatio: 1.6,
                      child: _BarChart(data: controller.leadStats!),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}


class _BarChart extends StatelessWidget {
  final List<LeadStatsModel> data;

  const _BarChart({required this.data});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: data.map((e) => e.count ?? 0).reduce((a, b) => a > b ? a : b) + 5,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      getTooltipColor: (group) => Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: AppColors.contentColorCyan,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue.darken(20),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = '';
    if (value.toInt() >= 0 && value.toInt() < data.length) {
      text = data[value.toInt()].day ?? '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient get _barsGradient => LinearGradient(
    colors: [
      AppColors.contentColorBlue.darken(20),
      AppColors.contentColorCyan,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData> get barGroups => data.asMap().entries.map((entry) {
    int index = entry.key;
    LeadStatsModel stats = entry.value;
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: stats.count?.toDouble() ?? 0,
          gradient: _barsGradient,
        )
      ],
      showingTooltipIndicators: [0],
    );
  }).toList();
}
