import 'package:e_learning/bloc/course/course_bloc.dart';
import 'package:e_learning/bloc/course/course_event.dart';
import 'package:e_learning/bloc/course/course_state.dart';
import 'package:e_learning/core/theme/app_colors.dart';

import 'package:e_learning/services/user_service.dart';
import 'package:e_learning/view/teacher/my_course/widgets/empty_courses_state.dart';
import 'package:e_learning/view/teacher/my_course/widgets/my_courses_app_bar.dart';
import 'package:e_learning/view/teacher/my_course/widgets/shimmer_courses.dart';
import 'package:e_learning/view/teacher/my_course/widgets/teacher_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyCourseScreen extends StatefulWidget {
  const MyCourseScreen({super.key});

  @override
  State<MyCourseScreen> createState() => _MyCourseScreenState();
}

class _MyCourseScreenState extends State<MyCourseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userService = UserService();
    final instructorId = userService.getCurrentUserId();
    if (instructorId != null) {
      context.read<CourseBloc>().add(UpdateCourse(instructorId));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final courseRepository = CoursesRepository();
    final userService = UserService();
    final instructorId = userService.getCurrentUserId();
    if (instructorId == null) {
      return const Center(child: Text("User not logged in"));
    }
    // final teacherCourses = DummyDataService.getInstructorCourses("inst_1");
    //if not work try this <coursebloc,coursestate>
    return BlocConsumer<CourseBloc, CourseState>(
        // future: courseRepository.getinstructorCourses(instructorId),
        listener: (context, state) {
      if (state is CourseDeleted) {
        Fluttertoast.showToast(
          msg: state.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    }, builder: (context, state) {
      // snapshot.connectionState == ConnectionState.waiting
      if (state is CourseLoading) {
        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          appBar: AppBar(
            title: const Text(
              "My Courses",
            ),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            itemBuilder: (context, index) => const ShimmerCourses(),
          ),
        );
      } else if (state is CourseError) {
        return Center(
          child: Text("Error: ${state.message}"),
        );
        //may be error at this point
      } else if (state is CourseLoaded) {
        final teacherCourses = state.courses;
        if (teacherCourses.isEmpty) {
          return Scaffold(
            backgroundColor: AppColors.lightBackground,
            appBar: AppBar(
              title: const Text("My Course"),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: const EmptyCoursesState(),
          );
        }

        // final teacherCourses = snapshot.data! as List;
        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const MyCoursesAppBar(),
              // if (teacherCourses.isEmpty)
              //   const SliverFillRemaining(
              //     child: EmptyCoursesState(),
              //   )
              // else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => TeacherCourseCard(
                      course: teacherCourses[index],
                    ),
                    childCount: teacherCourses.length,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        context.read<CourseBloc>().add(UpdateCourse(instructorId));
        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          appBar: AppBar(
            title: const Text("My Course"),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 5,
            itemBuilder: (context, index) =>
                const ShimmerCourses(), //check this shimmmer
          ),
        );
      }
    });
  }
}
