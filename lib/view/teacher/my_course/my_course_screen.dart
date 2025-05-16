import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/repositories/courses_repository.dart';
import 'package:e_learning/services/dummy_data_service.dart';
import 'package:e_learning/services/user_service.dart';
import 'package:e_learning/view/teacher/my_course/widgets/empty_courses_state.dart';
import 'package:e_learning/view/teacher/my_course/widgets/my_courses_app_bar.dart';
import 'package:e_learning/view/teacher/my_course/widgets/teacher_course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class MyCourseScreen extends StatelessWidget {
  const MyCourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final courseRepository = CoursesRepository();
    final userService = UserService();
    final instructorId = userService.getCurrentUserId();
    if (instructorId == null) {
      return Center(child: Text("User not logged in"));
    }
    // final teacherCourses = DummyDataService.getInstructorCourses("inst_1");
    return FutureBuilder(
        future: courseRepository.getinstructorCourses(instructorId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: AppColors.lightBackground,
              appBar: AppBar(
                title: Text(
                  "My Courses",
                ),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: \\${snapshot.error}"),
            );
            //may be error at this point
          } else if (snapshot.hasData && (snapshot.data as List).isEmpty) {
            return Scaffold(
              backgroundColor: AppColors.lightBackground,
              appBar: AppBar(
                title: Text("My Course"),
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body: EmptyCoursesState(),
            );
          } else {
            final teacherCourses = snapshot.data! as List;
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
          }
        });
  }
}
