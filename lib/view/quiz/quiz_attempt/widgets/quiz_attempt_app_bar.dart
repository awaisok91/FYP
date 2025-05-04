import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuizAttemptAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String formattedTime;
  final VoidCallback onSubmit;
  const QuizAttemptAppBar({
    super.key,
    required this.formattedTime,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      iconTheme: IconThemeData(
        color: AppColors.accent,
      ),
      title: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.accent.withOpacity(0.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 20,
              color: AppColors.accent,
            ),
            SizedBox(width: 8),
            Text(
              formattedTime,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accent,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 8),
          child: TextButton(
            onPressed: onSubmit,
            style: TextButton.styleFrom(
                backgroundColor: AppColors.accent.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
            child: Text(
              "Submit",
              style: theme.textTheme.labelLarge?.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
