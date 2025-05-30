import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/course.dart';
import 'package:flutter/material.dart';

class CourseInfoCard extends StatelessWidget {
  final Course course;
  const CourseInfoCard({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildInfoItem(
                  context,
                  Icons.people,
                  "${course.enrollmentCount}",
                  "Students",
                ),
                _buildInfoItem(
                  context,
                  Icons.star,
                  course.rating.toString(),
                  "${course.reviewCount} Reviews",
                ),
                _buildInfoItem(
                  context,
                  Icons.library_books,
                  "${course.lessons.length}",
                  "Lessons",
                ),
                _buildInfoItem(
                  context,
                  Icons.signal_cellular_alt,
                  course.level,
                  "Level",
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (course.requirments.isNotEmpty) ...[
              _buildSectionTitle(
                context,
                "Requirements",
              ),
              const SizedBox(height: 8),
              ...course.requirments.map(
                (reqirments) => _buildRequirmentsItem(
                  context,
                  reqirments,
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (course.whatYouWillLearn.isNotEmpty) ...[
              _buildSectionTitle(context, "What You Will Learn"),
              const SizedBox(height: 8),
              ...course.whatYouWillLearn.map(
                (item) => _buildLearningItem(context, item),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    IconData icon,
    String value,
    String label,
  ) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(
    BuildContext context,
    String title,
  ) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          // color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildRequirmentsItem(BuildContext context, String requirments) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        children: [
          const Text(
            ".",
            style: TextStyle(color: AppColors.primary),
          ),
          Expanded(
            child: Text(
              requirments,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLearningItem(BuildContext context, String item) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.primary,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              item,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
