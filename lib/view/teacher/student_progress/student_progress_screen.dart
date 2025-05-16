import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:e_learning/view/teacher/student_progress/widget/performance_card.dart';
import 'package:e_learning/view/teacher/student_progress/widget/student_progress_app_bar.dart';
import 'package:e_learning/view/teacher/student_progress/widget/student_progress_card.dart';
import 'package:flutter/material.dart';

class StudentProgressScreen extends StatelessWidget {
  const StudentProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studenProgress = DummyDataService.getStudentProgress("inst_1");
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const StudentProgressAppBar(),
            ];
          },
          body: TabBarView(
            children: [
              _buildCourseProgressTab(
                studenProgress,
              ),
              _buildPerformanceTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseProgressTab(List<StudentProgress> studentProgress) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: studentProgress.length,
      itemBuilder: (context, index) {
        final progress = studentProgress[index];
        return StudentProgressCard(
          progress: progress,
        );
      },
    );
  }

  Widget _buildPerformanceTab() {
    const instructorId = "inst_1"; // Define the instructorId
    final teacherStats =
        DummyDataService.getTeacherStats(instructorId); // Fetch teacher stats
    final engagement = teacherStats.studentEngagement;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: engagement.courseCompletionRates.length,
      itemBuilder: (context, index) {
        final courseName =
            engagement.courseCompletionRates.keys.elementAt(index);
        final completionRate =
            engagement.courseCompletionRates[courseName] ?? 0.0;
        return PerformanceCard(
          courseName: courseName,
          completionRate: completionRate,
          averageCompletionRate: engagement.averageCompletionRate,
          averageTimePerLesson: engagement.averageTimePerLesson,
        );
      },
    );
  }
}
