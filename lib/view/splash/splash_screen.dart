import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/models/user_model.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasNavigated = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted || _hasNavigated) return;
      _handleNavigation(context);
    });
  }

  void _handleNavigation(BuildContext context) async {
    if (_hasNavigated) return;
    _hasNavigated = true;

    final authState = context.read<AuthBloc>().state;

    // Ensure GetStorage is already initialized before calling this
    final isFirstTime = StorageServices.isFirstTime();

    if (isFirstTime) {
      await StorageServices.setFirstTime(false); // ✅ await this
      Get.offNamed(AppRoutes.onboarding);
    } else if (authState.userModel != null) {
      if (authState.userModel!.role == UserRole.student) {
        Get.offAllNamed(AppRoutes.main);
      } else {
        Get.offAllNamed(AppRoutes.main);
      }
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }

  // void _handleNavigation(BuildContext context) async {
  //   if (_hasNavigated) return;
  //   _hasNavigated = true;
  //   //remove this if neded
  //   // await StorageServices.setFirstTime(false);
  //   final authState = context.read<AuthBloc>().state;
  //   // final isFirstTime = StorageServices.isFirstTime();
  //   if (StorageServices.isFirstTime()) {
  //     //Navigate to onboarding screen
  //     StorageServices.setFirstTime(false);
  //     Get.offNamed(AppRoutes.onboarding);
  //   } else if (authState.userModel != null) {
  //     //Navigate based on user role
  //     if (authState.userModel!.role == UserRole.teacher) {
  //       Get.offAllNamed(AppRoutes.teacherHome);
  //     } else {
  //       Get.offAllNamed(AppRoutes.main);
  //     }
  //   } else {
  //     //Navigate to login screen
  //     Get.offNamed(AppRoutes.login);
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        color: theme.colorScheme.primary,
        child: SafeArea(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    // child: Icon(
                    //   Icons.school,
                    //   size: 80,
                    //   color: theme.colorScheme.primary,
                    // ),
                    child: Image.asset(
                      "tools/images/logo.png",
                      // color: theme.colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              //app name animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "E_Learning",
                        style: theme.textTheme.displayMedium?.copyWith(
                          color: theme.colorScheme.surface,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Learn Anywhere Achieve Everywhere",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.surface.withOpacity(1.0),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              FadeTransition(
                opacity: _fadeAnimation,
                child: CircularProgressIndicator(
                  color: theme.colorScheme.surface,
                  strokeWidth: 3,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
