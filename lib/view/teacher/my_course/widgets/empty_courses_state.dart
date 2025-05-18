import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            size: 80,
            color: AppColors.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "Start your teaching journey",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: AppColors.primary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Create your first course and share your knowledge.",
            textAlign: TextAlign.center,
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Get.toNamed(AppRoutes.createCourses),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 5,
              backgroundColor: AppColors.primary,
            ),
            child: const Text("Create Course"),
          ),
        ],
      ),
    );
  }
}
