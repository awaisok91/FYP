import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/teacher/teacher_analytics/widgets/enrollment_chart_widget.dart';
import 'package:e_learning/view/teacher/teacher_analytics/widgets/over_view_card_widget.dart';
import 'package:e_learning/view/teacher/teacher_analytics/widgets/revenue_stats_widget.dart';
import 'package:e_learning/view/teacher/teacher_analytics/widgets/student_engagement_widget.dart';
import 'package:e_learning/view/teacher/teacher_analytics/widgets/teacher_analytic_app_bar.dart';
import 'package:flutter/material.dart';

class TeacherAnalyticsScreen extends StatefulWidget {
  const TeacherAnalyticsScreen({super.key});

  @override
  State<TeacherAnalyticsScreen> createState() => _TeacherAnalyticsScreenState();
}

class _TeacherAnalyticsScreenState extends State<TeacherAnalyticsScreen> {
  final String instructorId = "inst_1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const TeacherAnalyticAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OverViewCardWidget(
                    instructorId: instructorId,
                  ),
                  const SizedBox(height: 24),
                  EnrollmentChartWidget(
                    instructorId: instructorId,
                  ),
                  const SizedBox(height: 24),
                  const RevenueStatsWidget(),
                  const SizedBox(height: 24),
                  StudentEngagementWidget(
                    instructorId: instructorId,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
