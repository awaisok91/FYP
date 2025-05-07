import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PerformanceCard extends StatelessWidget {
  final String courseName;
  final double completionRate;
  final int averageTimePerLesson;
  final double averageCompletionRate;
  const PerformanceCard({
    super.key,
    required this.courseName,
    required this.completionRate,
    required this.averageTimePerLesson,
    required this.averageCompletionRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.assessment,
                      color: AppColors.primary,
                    ),
                    Expanded(
                      child: Text(
                        courseName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildPerformanceMatric(
                  "Course Completion",
                  completionRate,
                ),
                _buildPerformanceMatric(
                  "Average Time per Lesson",
                  averageTimePerLesson/60,
                ),
                _buildPerformanceMatric(
                  "Overall Progress",
                  averageCompletionRate,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPerformanceMatric(
    String label,
    double value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            Text(
              "${(value * 100).toInt()}%",
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.grey,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 8,
          ),
        )
      ],
    );
  }
}
