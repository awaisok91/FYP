import 'package:e_learning/models/analytics_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeaklyProgressCard extends StatelessWidget {
  final List<WeeklyProgress> weaklyProgress;
  const WeaklyProgressCard({super.key, required this.weaklyProgress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Weakly Progress",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: weaklyProgress
                    .map((e) => e.minutes)
                    .reduce((a, b) => a > b ? a : b)
                    .toDouble(),
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                          // axisSide: meta.axisSide,
                          meta: meta,
                          // axisSide: meta.axisSide,
                          child: Text(
                            weaklyProgress[value.toInt()].day,
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: (value, meta) {
                        return SideTitleWidget(
                            meta: meta,
                            child: Text("${value.toInt()}m"));
                      },
                    ),
                  ),
                  rightTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: true),
                barGroups: weaklyProgress.asMap().entries.map((entry) {
                  // final index = entry.key;
                  // final progress = entry.value;
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.minutes.toDouble(),
                        color: Colors.blue,
                        width: 20,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
