import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyCoursesState extends StatelessWidget {
  const EmptyCoursesState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.school_outlined,
            size: 64,
            color: AppColors.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No Course yet",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary.withOpacity(0.7),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              //navigate to create course screen
            },
            child: const Text("Create Your First Course"),
          ),
        ],
      ),
    );
  }
}
