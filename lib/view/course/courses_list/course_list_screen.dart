
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/course/courses_list/widgets/course_card.dart';
import 'package:e_learning/view/course/courses_list/widgets/course_filter_dialog.dart';
import 'package:e_learning/view/course/courses_list/widgets/empty_state_widget.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseListScreen extends StatelessWidget {
  final String? categoryId;
  final String? categoryName;
  final bool showBackButton;
  const CourseListScreen({
    super.key,
    this.categoryId,
    this.categoryName,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final courses = categoryId != null
        ? DummyDataService.getCoursesByCateogory(categoryId!)
        : DummyDataService.courses;
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            automaticallyImplyLeading: categoryId != null && showBackButton,
            leading: categoryId != null && showBackButton
                ? IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                : null,
            actions: [
              IconButton(
                onPressed: () => _showFilterDialog(context),
                icon: const Icon(
                  Icons.filter_list,
                  color: AppColors.accent,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                categoryName ?? "Courses",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryLight,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          if (courses.isEmpty)
            SliverFillRemaining(
              child: EmptyStateWidget(
                onActionPressed: () => Get.back(),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Add your item builder logic here
                    final course = courses[index];
                    return CourseCard(
                      courseId: course.id,
                      title: course.title,
                      subtitle: course.description,
                      imageUrl: course.imageUrl,
                      rating: course.rating,
                      duration: '${course.lessons.length * 30} min',
                      isPremium: course.ispremium,
                    ); // Example placeholder widget
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => const CourseFilterDialog(),
    );
  }
}
