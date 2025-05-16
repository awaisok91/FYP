import 'package:e_learning/main_screen.dart';
import 'package:e_learning/view/auth/forgot_password_screen.dart';
import 'package:e_learning/view/auth/login_screen.dart';
import 'package:e_learning/view/auth/register_screen.dart';
import 'package:e_learning/view/course/analytics_dashboard/analytics_dashboard_screen.dart';
import 'package:e_learning/view/course/course_detail/course_detail_screen.dart';

import 'package:e_learning/view/course/courses_list/course_list_screen.dart';
import 'package:e_learning/view/course/lesson_screen/lesson_screen.dart';
import 'package:e_learning/view/help_&_support/help_and_support_screen.dart';
import 'package:e_learning/view/home/home_screen.dart';
import 'package:e_learning/view/notification/notification_screen.dart';
import 'package:e_learning/view/onboarding/onboarding_screen.dart';
import 'package:e_learning/view/privacy_&_Terms_condition/privacy_policy_screen.dart';
import 'package:e_learning/view/privacy_&_Terms_condition/term_condition_screen.dart';
import 'package:e_learning/view/profile/edit_profile_screen.dart';
import 'package:e_learning/view/profile/profile_screen.dart';
import 'package:e_learning/view/quiz/quiz_attempt/quiz_attempt_screen.dart';
import 'package:e_learning/view/quiz/quiz_list/quiz_list_screen.dart';
import 'package:e_learning/view/settings/setting_screen.dart';
import 'package:e_learning/view/splash/splash_screen.dart';
import 'package:e_learning/view/teacher/create_course/create_course_screen.dart';
import 'package:e_learning/view/teacher/my_course/my_course_screen.dart';
import 'package:e_learning/view/teacher/student_progress/student_progress_screen.dart';
import 'package:e_learning/view/teacher/teacher_analytics/teacher_analytics_screen.dart';
import 'package:e_learning/view/teacher/teacher_home/teacher_home_screen.dart';
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
  static const String analytics = '/analytics';
  static const String lesson = '/lesson/:id';

  //quizzes route
  static const String quizList = '/quizzes';
  static const String quizAttempt = '/quiz/:id';
  static const String quizresult = '/quiz/result';

  //profile route
  static const String profile = '/profile';
  static const String editprofile = '/profile/edit';
  static const String notifications = '/notifications';
  static const String setting = '/setting';
  static const String privacyPolicy = '/privacy-policy';
  static const String termCondition = '/term-condition';
  static const String helpAndSupport = '/help-support';

  //teacher
  static const String teacherHome = '/teacher/home';
  static const String myCourses = '/teacher/courses';
  static const String createCourses = '/teacher/courses/create';
  static const String teacherAnalytics = '/teacher/analytics';
  static const String studentProgress = '/teacher/student';

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

      case myCourses:
        return MaterialPageRoute(
          builder: (_) => const MyCourseScreen(),
        );

      case studentProgress:
        return MaterialPageRoute(
          builder: (_) => const StudentProgressScreen(),
        );

      case createCourses:
        return MaterialPageRoute(
          builder: (_) => const CreateCourseScreen(),
        );

      case teacherAnalytics:
        return MaterialPageRoute(
          builder: (_) => const TeacherAnalyticsScreen(),
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

      case editprofile:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
        );

      case notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );

      case setting:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
        );

      case privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyScreen(),
        );

      case termCondition:
        return MaterialPageRoute(
          builder: (_) => const TermConditionScreen(),
        );

        case helpAndSupport:
        return MaterialPageRoute(
          builder: (_) => const HelpAndSupportScreen(),
        );

      case analytics:
        return MaterialPageRoute(
          builder: (_) => AnalyticsDashboardScreen(),
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
