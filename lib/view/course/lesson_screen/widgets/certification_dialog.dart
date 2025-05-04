import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/models/course.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CertificationDialog extends StatelessWidget {
  final Course course;
  final VoidCallback onDownload;
  const CertificationDialog({
    super.key,
    required this.course,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Congratulations"),
      content: Column(
        children: [
          const Icon(
            Icons.workspace_premium,
            size: 64,
            color: AppColors.primary,
          ),
          const SizedBox(height: 16),
          Text(
            "You have completed all lessons in \"${course.title}\"",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            "You can now download your certification of completion",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.secondary,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                )),
                child: const Text(
                  "Later",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  onDownload();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  backgroundColor: AppColors.primary,
                ),
                child: const Text(
                  "Later",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
