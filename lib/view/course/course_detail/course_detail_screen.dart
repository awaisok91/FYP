import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/course/course_detail/widgets/action_button.dart';
import 'package:e_learning/view/course/course_detail/widgets/course_detail_app_bar.dart';
import 'package:e_learning/view/course/course_detail/widgets/course_info_card.dart';
import 'package:e_learning/view/course/course_detail/widgets/lesson_list.dart';
import 'package:e_learning/view/course/course_detail/widgets/review_section.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  const CourseDetailScreen({
    super.key,
    required this.courseId,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lastLesson = Get.parameters["lastLesson"];
    final id = Get.parameters['id'] ?? widget.courseId;
    final course = DummyDataService.getCourseById(id);
    final isCompleted = DummyDataService.isCourseCompleted(course.id);
    final isUnlocked = DummyDataService.isCourseUlocked(widget.courseId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CourseDetailAppBar(
            imageUrl: course.imageUrl,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    course.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "(${course.rating} review)",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$${course.price}",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    course.description,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  CourseInfoCard(
                    course: course,
                  ),
                  const SizedBox(height: 24),
                  LessonList(
                    courseId: widget.courseId,
                    isUnlocked: isUnlocked,
                    onLessonComplets: () => setState(() {}),
                  ),
                  const SizedBox(height: 24),
                  ReviewSection(
                    courseId: widget.courseId,
                  ),
                  const SizedBox(height: 24),
                  ActionButton(
                    course: course,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: course.ispremium && !isUnlocked
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  //navigate to payment screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(16),
                ),
                child: Text("Buy Now for \$${course.price}"),
              ),
            )
          : null,
    );
  }
}
