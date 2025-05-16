import 'package:e_learning/bloc/auth/auth_bloc.dart';
import 'package:e_learning/bloc/auth/auth_event.dart';
import 'package:e_learning/core/utils/app_dialogs.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/view/profile/widgets/profile_option_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileOptionCard(
          title: "Edit Profile",
          subtitle: "Update your personal information",
          icon: Icons.edit_outlined,
          onTap: () => Get.toNamed(AppRoutes.editprofile),
        ),
        ProfileOptionCard(
          title: "Notifications",
          subtitle: "Manage your notification",
          icon: Icons.notifications_outlined,
          onTap: () => Get.toNamed(AppRoutes.notifications),
        ),
        ProfileOptionCard(
          title: "Settings",
          subtitle: "App preferences and more",
          icon: Icons.settings_outlined,
          onTap: () => Get.toNamed(AppRoutes.setting),
        ),
        ProfileOptionCard(
          title: "Help & Support",
          subtitle: "Get heil or contact support",
          icon: Icons.help_outline,
          onTap: () => Get.toNamed(AppRoutes.helpAndSupport),
        ),
        ProfileOptionCard(
          title: "logout",
          subtitle: "Sign out of your account",
          icon: Icons.logout,
          onTap: () async {
            final confirm = await AppDialogs.showLogoutDialog();
            if (confirm == true) {
              // Get.offAllNamed(AppRoutes.login);
              context.read<AuthBloc>().add(
                LogoutRequested()
              );
            }
          },
          isDestructive: true,
        ),
      ],
    );
  }
}
