import 'package:e_learning/bloc/course/course_bloc.dart';
import 'package:e_learning/bloc/course/course_event.dart';
import 'package:e_learning/bloc/course/course_state.dart';
import 'package:e_learning/models/course.dart';
import 'package:e_learning/models/user_model.dart';
import 'package:e_learning/repositories/instructor_repository.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:e_learning/view/home/widgets/recommended_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({super.key});

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  final _instructorRepository = InstructorRepository();
  Map<String, UserModel> _instructors = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CourseBloc>().add(LoadCourse());
  }

  Future<void> _loadInstructors(List<Course> courses) async {
    final instructorIds = courses.map((c) => c.instructorId).toSet().toList();
    try {
      _instructors =
          await _instructorRepository.getInstructorByIds(instructorIds);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint("Failed to Load Instructor: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final courses = DummyDataService.courses;
    return BlocConsumer<CourseBloc, CourseState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CourseLoaded) {
          _loadInstructors(state.courses);
        }
      },
      builder: (context, state) {
        if (state is CourseLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CourseLoaded) {
          final courses = state.courses;
          if (courses.isEmpty) {
            return const Center(
              child: Text("No courses available"),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recomended",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.courseslist),
                    child: const Text(
                      "See All",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: courses.length,
                  itemBuilder: (context, index) {
                    final course = courses[index];
                    final instructor = _instructors[course.instructorId];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: RecommendedCourseCard(
                        courseId: course.id,
                        title: course.title,
                        imageUrl: course.imageUrl,
                        instructorName:
                            instructor?.fullName ?? "Unknown Instructor",
                        // duration: '${course.lessons.length * 30} mins',
                        rating: course.rating,
                        reviewCount: course.reviewCount,
                        price: course.price,
                        isPremium: course.ispremium,
                        onTap: () => Get.toNamed(
                          AppRoutes.courseDetail.replaceAll(":id", course.id),
                          arguments: course.id,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        if (state is CourseError) {
          return Center(
            child: Text(state.message),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
