import 'package:e_learning/main_screen.dart';
import 'package:e_learning/view/auth/forgot_password_screen.dart';
import 'package:e_learning/view/auth/login_screen.dart';
import 'package:e_learning/view/auth/register_screen.dart';
import 'package:e_learning/view/course/course_detail/course_detail_screen.dart';

import 'package:e_learning/view/course/courses_list/course_list_screen.dart';
import 'package:e_learning/view/course/lesson_screen/lesson_screen.dart';
import 'package:e_learning/view/home/home_screen.dart';
import 'package:e_learning/view/onboarding/onboarding_screen.dart';
import 'package:e_learning/view/profile/profile_screen.dart';
import 'package:e_learning/view/quiz/quiz_attempt/quiz_attempt_screen.dart';
import 'package:e_learning/view/quiz/quiz_list/quiz_list_screen.dart';
import 'package:e_learning/view/quiz/quiz_result/quiz_result_screen.dart';
import 'package:e_learning/view/splash/splash_screen.dart';
import 'package:e_learning/view/teacher/teacher_home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  //main
  static const String main = '/main';

  //auth routes
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  //courses route
  static const String courseslist = '/courses';
  static const String courseDetail = '/course/:id';
  static const String lesson = '/lesson/:id';

  //quizzes route
  static const String quizList = '/quizzes';
  static const String quizAttempt = '/quiz/:id';
  static const String quizresult = '/quiz/result';

  //profile route
  static const String profile = '/profile';

  //teacher
  static const String teacherHome = '/teacher/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );
      case main:
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            //if it not work follow the vedio
            initialIndex: (settings.arguments
                as Map<String, dynamic>)['initialIndex'] as int?,
          ),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case teacherHome:
        return MaterialPageRoute(
          builder: (_) => const TeacherHomeScreen(),
        );
      case courseslist:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CourseListScreen(
            categoryId: args?['categoryId'] as String?,
            categoryName: args?['categoryName'] as String?,
            // showBackButton: true,
          ),
        );
      case courseDetail:
        String courseId;
        if (settings.arguments != null) {
          courseId = settings.arguments as String;
        } else {
          final uir = Uri.parse(settings.name ?? "");
          courseId = uir.pathSegments.last;
        }
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(courseId: courseId),
        );
      case quizList:
        final quizId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => QuizAttemptScreen(
            quizId: quizId ?? "",
          ),
        );
      case quizAttempt:
        return MaterialPageRoute(
          builder: (_) => const QuizListScreen(),
        );

      case lesson:
        final lessonId = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => LessonScreen(
            lessonId: lessonId ?? '',
          ),
        );
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Routes Are Not Found'),
            ),
          ),
        );
    }
  }
}
