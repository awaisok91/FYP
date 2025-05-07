import 'package:e_learning/view/home/widgets/dummy_data_service.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EnrollmentChartWidget extends StatelessWidget {
  final String instructorId;
  const EnrollmentChartWidget({super.key, required this.instructorId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
            "Enrollement Trends",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 200,
            child: _buildEnrollmentLineChart(),
          )
        ],
      ),
    );
  }

  Widget _buildEnrollmentLineChart() {
    // Dummy data for enrollment trends
    final stats = DummyDataService.getTeacherStats(instructorId);
    // final enrollments = [10, 20, 15, 30, 25, 40]; // Replace with actual data
    final enrollments = stats.monthlyEnrollments;
    // Create spots for the line chart
    final spots = List.generate(
      enrollments.length,
      (index) => FlSpot(index.toDouble(), enrollments[index].toDouble()),
    );

    return LineChart(
      LineChartData(
        gridData: const FlGridData(
          show: true,
          drawVerticalLine: false,
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 12),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        minX: 0,
        maxX: (enrollments.length - 1).toDouble(),
        minY: 0,
        // maxY: enrollments.reduce((a, b) => a > b ? a : b) * 1.2,
        maxY: enrollments.isNotEmpty
            ? enrollments.reduce((a, b) => a > b ? a : b).toDouble()
            : 1.0, // Default to 1.0 if enrollments is empty
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: Colors.blue,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.blue.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
