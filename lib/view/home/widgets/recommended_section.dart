import 'package:e_learning/view/home/widgets/dummy_data_service.dart';
import 'package:e_learning/view/home/widgets/recommended_course_card.dart';
import 'package:flutter/material.dart';

class RecommendedSection extends StatelessWidget {
  const RecommendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courses = DummyDataService.courses;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recomended",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "See All",
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return RecommendedCourseCard(
                courseId: course.id,
                title: course.title,
                imageUrl: course.imageUrl,
                instructorId: course.instructorId,
                duration: '${course.lessons.length * 30}mins',
                isPremium: course.ispremium,
              );
            },
          ),
        )
      ],
    );
  }
}
