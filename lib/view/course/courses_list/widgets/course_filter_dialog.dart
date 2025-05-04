import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CourseFilterDialog extends StatelessWidget {
  const CourseFilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Filter Courses",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          _buildFilterOption(context, "All Levels", true),
          _buildFilterOption(context, "Beginner", false),
          _buildFilterOption(context, "Intermediate", false),
          _buildFilterOption(context, "Advanced", false),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                    // Handle apply filter action
                    Navigator.pop(context),
                  
                  child: const Text("Apply"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () =>
                    // Handle clear filter action
                    Navigator.pop(context),
                  
                  child: const Text("Reset"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFilterOption(
    BuildContext context,
    String label,
    bool isSelected,
  ) {
    return ListTile(
      title: Text(label),
      trailing: isSelected
          ? const Icon(
              Icons.check_circle,
              color: AppColors.primary,
            )
          : const Icon(
              Icons.circle_outlined,
            ),
      onTap: () {
        // Handle filter option tap
        Navigator.pop(context);
      },
    );
  }
}
