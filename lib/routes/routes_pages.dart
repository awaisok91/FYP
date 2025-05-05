import 'package:e_learning/main_screen.dart';
import 'package:e_learning/models/quiz.dart';
import 'package:e_learning/models/quiz_attempt.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/view/auth/forgot_password_screen.dart';
import 'package:e_learning/view/auth/login_screen.dart';
import 'package:e_learning/view/auth/register_screen.dart';
import 'package:e_learning/view/course/course_detail/course_detail_screen.dart';

import 'package:e_learning/view/course/courses_list/course_list_screen.dart';
import 'package:e_learning/view/course/lesson_screen/lesson_screen.dart';
import 'package:e_learning/view/home/home_screen.dart';
import 'package:e_learning/view/notification/notification_screen.dart';
import 'package:e_learning/view/onboarding/onboarding_screen.dart';
import 'package:e_learning/view/profile/profile_screen.dart';
import 'package:e_learning/view/quiz/quiz_attempt/quiz_attempt_screen.dart';
import 'package:e_learning/view/quiz/quiz_list/quiz_list_screen.dart';
import 'package:e_learning/view/quiz/quiz_result/quiz_result_screen.dart';
import 'package:e_learning/view/splash/splash_screen.dart';
import 'package:e_learning/view/teacher/create_course/create_course_screen.dart';
import 'package:e_learning/view/teacher/my_course/my_course_screen.dart';
import 'package:e_learning/view/teacher/teacher_home/teacher_home_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(
        initialIndex: Get.arguments is Map<String, dynamic>
            ? Get.arguments['initialIndex'] as int?
            : null,
      ),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.courseslist,
      page: () => CourseListScreen(
        categoryId: Get.arguments?['categoryId'] as String?,
        categoryName: Get.arguments?['categoryName'] as String?,
      ),
    ),
    GetPage(
      name: "/course/:id",
      page: () => CourseDetailScreen(
        courseId: Get.parameters["id"] ?? '',
      ),
    ),
    GetPage(
      name: AppRoutes.quizList,
      page: () => const QuizListScreen(),
    ),
    GetPage(
      name: "/quiz/:id",
      page: () => QuizAttemptScreen(
        quizId: Get.parameters["id"] ?? "",
      ),
    ),
    GetPage(
      name: "/quiz/:id",
      page: () => QuizResultScreen(
        attempt: Get.arguments['attemp'] as QuizAttempt,
        quiz: Get.arguments['quiz'] as Quiz,
      ),
    ),
    GetPage(
      name: AppRoutes.lesson,
      page: () => LessonScreen(
        lessonId: Get.parameters["id"] ?? '',
      ),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: AppRoutes.teacherHome,
      page: () => const TeacherHomeScreen(),
    ),
    GetPage(
      name: AppRoutes.myCourses,
      page: () => const MyCourseScreen(),
    ),
    GetPage(
      name: AppRoutes.createCourses,
      page: () => const CreateCourseScreen(),
    ),
  ];
}
