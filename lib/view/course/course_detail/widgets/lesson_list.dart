
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/view/course/course_detail/widgets/lesson_tile.dart';
import 'package:e_learning/view/home/widgets/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LessonList extends StatelessWidget {
  final String courseId;
  final bool isUnlocked;
  final VoidCallback? onLessonComplets;
  const LessonList({
    super.key,
    required this.courseId,
    required this.isUnlocked,
    this.onLessonComplets,
  });

  @override
  Widget build(BuildContext context) {
    final course = DummyDataService.getCourseById(courseId);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: course.lessons.length,
      itemBuilder: (context, index) {
        final lesson = course.lessons[index];
        final isLocked = !lesson.isPreview &&
            (index > 0 &&
                !DummyDataService.isLessonCompleated(
                    course.id, course.lessons[index - 1].id));
        return LessonTile(
          title: lesson.title,
          duration: "${lesson.duration} min",
          isCompleted:
              DummyDataService.isLessonCompleated(course.id, lesson.id),
          isLocked: isLocked,
          isUnlocked: isUnlocked,
          onTap: () async {
            if (course.ispremium && !isUnlocked) {
              Get.snackbar(
                "Premium Course",
                "Please purchase this cousre to access all lessons",
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
              );
            } else if (isLocked) {
              Get.snackbar(
                "Lesson Locked",
                "please compleat the previous lesson first",
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
              );
            } else {
              //Navigate to lesson screen
              final result = await Get.toNamed(
                AppRoutes.lesson.replaceAll("id", lesson.id),
                parameters: {
                  "courseId": courseId,
                },
              );
              if (result == true) {
                onLessonComplets?.call();
              }
            }
          },
        );
      },
    );
  }
}
