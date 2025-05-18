import 'package:e_learning/bloc/course/course_bloc.dart';
import 'package:e_learning/bloc/course/course_event.dart';
import 'package:e_learning/bloc/course/course_state.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/course/courses_list/widgets/course_card.dart';
import 'package:e_learning/view/course/courses_list/widgets/course_filter_dialog.dart';
import 'package:e_learning/view/course/courses_list/widgets/empty_state_widget.dart';
import 'package:e_learning/view/teacher/my_course/widgets/shimmer_courses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CourseListScreen extends StatefulWidget {
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
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //load course when the screen is initilized
    context.read<CourseBloc>().add(LoadCourse(categoryId: widget.categoryId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final courses = widget.categoryId != null
    //     ? DummyDataService.getCoursesByCateogory(widget.categoryId!)
    //     : DummyDataService.courses;
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: BlocBuilder<CourseBloc, CourseState>(builder: (context, state) {
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: AppColors.primary,
              automaticallyImplyLeading:
                  widget.categoryId != null && widget.showBackButton,
              leading: widget.categoryId != null && widget.showBackButton
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
                  widget.categoryName ?? "Courses",
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
            if (state is CourseLoading)
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    //check shimmer its may be shimmmercoursecard
                    (context, index) => const ShimmerCourses(),
                    childCount: 5,
                  ),
                ),
              )
            else if (state is CourseError)
              SliverFillRemaining(
                child: Center(
                  child: Text(
                    state.message,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              )
            else if (state is CourseLoaded && state.courses.isEmpty)
              SliverFillRemaining(
                child: EmptyStateWidget(
                  onActionPressed: () => Get.back(),
                ),
              )
            else if (state is CourseLoaded)
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // Add your item builder logic here
                      final course = state.courses[index];
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
                    childCount: state.courses.length,
                  ),
                ),
              ),
          ],
        );
      }),
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
