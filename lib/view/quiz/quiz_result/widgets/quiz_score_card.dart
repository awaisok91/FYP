import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class QuizScoreCard extends StatelessWidget {
  final int percentage;
  final bool isPassed;

  const QuizScoreCard({
    super.key,
    required this.percentage,
    required this.isPassed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        children: [
          Text(
            isPassed ? "Congratulation" : "Keep Practicing!",
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "$percentage%",
            style: theme.textTheme.displayLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isPassed ? Colors.green : Colors.orange,
            ),
          ),
          Text(
            "Score",
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
