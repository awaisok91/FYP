import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/home/widgets/dummy_data_service.dart';
import 'package:e_learning/view/teacher/my_course/widgets/empty_courses_state.dart';
import 'package:e_learning/view/teacher/my_course/widgets/my_courses_app_bar.dart';
import 'package:e_learning/view/teacher/my_course/widgets/teacher_course_card.dart';
import 'package:flutter/material.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final teacherCourses = DummyDataService.getInstructorCourses("inst_1");
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const MyCoursesAppBar(),
          if (teacherCourses.isEmpty)
            const SliverFillRemaining(
              child: EmptyCoursesState(),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => TeacherCourseCard(
                    course: teacherCourses[index],
                  ),
                  childCount: teacherCourses.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
