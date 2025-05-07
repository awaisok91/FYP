import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/analytics_data.dart';
import 'package:flutter/material.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Learning Analytics",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // body: FutureBuilder<AnalyticsData>(future: future, builder: (context,index){}),
    );
  }
}
