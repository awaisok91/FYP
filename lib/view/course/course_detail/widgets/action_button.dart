import 'package:e_learning/models/course.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/view/home/widgets/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButton extends StatelessWidget {
  final Course course;
  const ActionButton({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (course.ispremium &&
                  !DummyDataService.isCourseUlocked(course.id)) {
                //Navigate to payment screen
                //its for payment screen but not work there know
                // Get.toNamed(AppRoutes.payment, arguments: {
                //   "courseId": course.id,
                //   "courseName": course.title,
                //   "prise": course.price,
                // });
              } else {
                //Navigate to first lesson if course is free
                Get.toNamed(
                    AppRoutes.lesson.replaceAll(":id", course.lessons.first.id),
                    parameters: {
                      "courseId": course.id,
                    });
              }
            },
            label: const Text("Start Learning"),
            icon: const Icon(Icons.play_circle),
          ),
        ),
        //only show chat button if course is not premium
        if (!course.ispremium ||
            DummyDataService.isCourseUlocked(course.id)) ...{
          const SizedBox(height: 16),
          IconButton(
            onPressed: () {
              //navigate to chat screen
            },
            icon: const Icon(Icons.chat),
          ),
        }
      ],
    );
  }
}
