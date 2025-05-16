import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/bloc/auth/auth_event.dart';
import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/core/utils/app_dialogs.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/view/teacher/teacher_home/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: AppColors.primary,
            actions: [
              IconButton(
                onPressed: () async {
                  final confirm = await AppDialogs.showLogoutDialog();
                  if (confirm == true) {
                    // Get.offNamed(AppRoutes.login);
                    context.read<AuthBloc>().add(LogoutRequested());
                  }
                },
                icon: const Icon(Icons.logout),
                color: AppColors.accent,
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Teacher Dashboard",
                style: TextStyle(
                  color: AppColors.accent,
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
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildListDelegate(
                [
                  DashboardCard(
                      title: "My Course",
                      icon: Icons.book,
                      onTap: () => Get.toNamed(AppRoutes.myCourses)),
                  DashboardCard(
                      title: "Create Course",
                      icon: Icons.add_circle,
                      onTap: () => Get.toNamed(AppRoutes.createCourses)),
                  DashboardCard(
                      title: "Analytics",
                      icon: Icons.analytics,
                      onTap: () => Get.toNamed(AppRoutes.teacherAnalytics)),
                  DashboardCard(
                      title: "Student progress",
                      icon: Icons.people,
                      onTap: () => Get.toNamed(AppRoutes.studentProgress)),
                  DashboardCard(
                    title: "Messages",
                    icon: Icons.message,
                    onTap: () {
                      // Add your onTap functionality here
                    },
                  ),
                ],
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
