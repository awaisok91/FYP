import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileStateCard extends StatelessWidget {
  const ProfileStateCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildstat(theme, '12', "Courses"),
            _buildstat(theme, '156', "Houres"),
            _buildstat(theme, '89%', "Success"),
          ],
        ),
      ),
    );
  }

  Widget _buildstat(
    ThemeData theme,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondary,
            ))
      ],
    );
  }
}
