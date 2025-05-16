import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/analytics_data.dart';
import 'package:e_learning/services/analytics_service.dart';
import 'package:e_learning/view/course/analytics_dashboard/widget/learning_streak_card.dart';
import 'package:e_learning/view/course/analytics_dashboard/widget/recomendation_card.dart';
import 'package:e_learning/view/course/analytics_dashboard/widget/skill_progress_card.dart';
import 'package:e_learning/view/course/analytics_dashboard/widget/weakly_progress_card.dart';
import 'package:flutter/material.dart';

class AnalyticsDashboardScreen extends StatelessWidget {
  AnalyticsDashboardScreen({super.key});
  final _analyticService = AnalyticsService();
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
      body: FutureBuilder<AnalyticsData>(
        future: _analyticService.getUserAnalytics("Current_user_id"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final analytics = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LearningStreakCard(
                    learningStreak: analytics.learningstreak,
                  ),
                  const SizedBox(height: 20),
                  WeaklyProgressCard(
                    weaklyProgress: analytics.weeklyProgress,
                  ),
                  const SizedBox(height: 20),
                  SkillProgressCard(
                    skillprogress: analytics.skillProgress,
                  ),
                  const SizedBox(height: 20),
                  RecomendationCard(
                    recomendation: analytics.recommendation,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
