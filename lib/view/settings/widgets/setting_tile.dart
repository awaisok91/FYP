import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? traling;
  final VoidCallback? onTap;
  const SettingTile({
    super.key,
    required this.title,
    required this.icon,
    this.traling,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                icon,
                // color: AppColors.primary,
                color: Colors.blue,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              if (traling != null) traling!,
              if (onTap != null)
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.secondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
