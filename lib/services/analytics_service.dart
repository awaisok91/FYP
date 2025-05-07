import 'package:e_learning/models/analytics_data.dart';

class AnalyticsService {
  Future<AnalyticsData> getUserAnalytics(String userId) async {
    return AnalyticsData(
        completionRate: 0.72,
        totalTimeSpent: 4320,
        averageQuizScore: 88.6,
        skillProgress: {
          "Flutter": 0.87,
          "Dart": 0.67,
          "Ui Design": 0.89,
          "State Mangement": 0.95,
          "Testing": 0.64,
        },
        recommendation: [
          "Compleate Advanced State Management,To improve your skills",
          "Prectice more flutter testing to increase your text coverage skills",
        ],
        weeklyProgress: [
          WeeklyProgress(day: 'Mon', minutes: 45),
          WeeklyProgress(day: 'tue', minutes: 65),
          WeeklyProgress(day: 'wed', minutes: 34),
          WeeklyProgress(day: 'tur', minutes: 76),
          WeeklyProgress(day: 'fri', minutes: 86),
          WeeklyProgress(day: 'sat', minutes: 33),
          WeeklyProgress(day: 'sun', minutes: 98),
        ],
        learningstreak: {
          "current": 5,
          "longest": 13,
          "total": 65,
        },
        totalCoursesEnrolled: 6,
        certificatesEarned: 3);
  }

  Future<AnalyticsData> updateCourseProgress(
    String userId,
    String courseId,
    double progress,
    AnalyticsData currentAnalytics,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AnalyticsData(
      completionRate: (currentAnalytics.completionRate + progress) / 2,
      totalTimeSpent: currentAnalytics.totalTimeSpent,
      averageQuizScore: currentAnalytics.averageQuizScore,
      skillProgress: currentAnalytics.skillProgress,
      recommendation: currentAnalytics.recommendation,
      weeklyProgress: currentAnalytics.weeklyProgress,
      learningstreak: currentAnalytics.learningstreak,
      totalCoursesEnrolled: currentAnalytics.totalCoursesEnrolled,
      certificatesEarned: currentAnalytics.certificatesEarned,
    );
  }

  Future<AnalyticsData> UpdateQuizScore(
    String userId,
    String quizId,
    double score,
    AnalyticsData currentAnalytics,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AnalyticsData(
      completionRate: currentAnalytics.completionRate,
      totalTimeSpent: currentAnalytics.totalTimeSpent,
      averageQuizScore: (currentAnalytics.averageQuizScore + score) / 2,
      skillProgress: currentAnalytics.skillProgress,
      recommendation: currentAnalytics.recommendation,
      weeklyProgress: currentAnalytics.weeklyProgress,
      learningstreak: currentAnalytics.learningstreak,
      totalCoursesEnrolled: currentAnalytics.totalCoursesEnrolled,
      certificatesEarned: currentAnalytics.certificatesEarned,
    );
  }

  Future<AnalyticsData> updateLearningStreak(
    String userId,
    AnalyticsData currentAnalytics,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final currentStreak = currentAnalytics.learningstreak["current"]! + 1;
    final longestStreak =
        currentStreak > currentAnalytics.learningstreak["longest"]!
            ? currentStreak
            : currentAnalytics.learningstreak["longest"]!;
    return AnalyticsData(
      completionRate: currentAnalytics.completionRate,
      totalTimeSpent: currentAnalytics.totalTimeSpent,
      averageQuizScore: currentAnalytics.averageQuizScore,
      skillProgress: currentAnalytics.skillProgress,
      recommendation: currentAnalytics.recommendation,
      weeklyProgress: currentAnalytics.weeklyProgress,
      learningstreak: {
        "current": currentStreak,
        "longest": longestStreak,
        "total": currentAnalytics.learningstreak["total"]! + 1,
      },
      totalCoursesEnrolled: currentAnalytics.totalCoursesEnrolled,
      certificatesEarned: currentAnalytics.certificatesEarned,
    );
  }

  Future<AnalyticsData> updateSkillProgress(
    String userId,
    String skillName,
    double progress,
    AnalyticsData currentAnalytics,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final updateSkillProgress =
        Map<String, double>.from(currentAnalytics.skillProgress);
    updateSkillProgress[skillName] = progress;
    return AnalyticsData(
      completionRate: currentAnalytics.completionRate,
      totalTimeSpent: currentAnalytics.totalTimeSpent,
      averageQuizScore: currentAnalytics.averageQuizScore,
      skillProgress: updateSkillProgress,
      recommendation: currentAnalytics.recommendation,
      weeklyProgress: currentAnalytics.weeklyProgress,
      learningstreak: currentAnalytics.learningstreak,
      totalCoursesEnrolled: currentAnalytics.totalCoursesEnrolled,
      certificatesEarned: currentAnalytics.certificatesEarned,
    );
  }

  Future<AnalyticsData> compleateLesson(
    String userId,
    String courseId,
    double lessonId,
    AnalyticsData currentAnalytics,
  ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AnalyticsData(
      completionRate: currentAnalytics.completionRate + 0.05,
      totalTimeSpent: currentAnalytics.totalTimeSpent + 45,
      averageQuizScore: currentAnalytics.averageQuizScore,
      skillProgress: currentAnalytics.skillProgress,
      recommendation: currentAnalytics.recommendation,
      weeklyProgress: currentAnalytics.weeklyProgress,
      learningstreak: currentAnalytics.learningstreak,
      totalCoursesEnrolled: currentAnalytics.totalCoursesEnrolled,
      certificatesEarned: currentAnalytics.certificatesEarned,
    );
  }

  Future<AnalyticsData> earnCertificaate(
      String userId, String courseid, AnalyticsData currentAnalytics) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return AnalyticsData(
      completionRate: currentAnalytics.completionRate,
      totalTimeSpent: currentAnalytics.totalTimeSpent,
      averageQuizScore: currentAnalytics.averageQuizScore,
      skillProgress: currentAnalytics.skillProgress,
      recommendation: currentAnalytics.recommendation,
      weeklyProgress: currentAnalytics.weeklyProgress,
      learningstreak: currentAnalytics.learningstreak,
      totalCoursesEnrolled: currentAnalytics.totalCoursesEnrolled,
      certificatesEarned: currentAnalytics.certificatesEarned + 1,
    );
  }
}
