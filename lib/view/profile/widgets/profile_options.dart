import 'package:e_learning/core/utils/app_dialogs.dart';
import 'package:e_learning/routes/app_routes.dart';
import 'package:e_learning/view/profile/widgets/profile_option_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
          onTap: () {},
        ),
        ProfileOptionCard(
          title: "Help & Support",
          subtitle: "Get heil or contact support",
          icon: Icons.help_outline,
          onTap: () {},
        ),
        ProfileOptionCard(
          title: "logout",
          subtitle: "Sign out of your account",
          icon: Icons.logout,
          onTap: () async {
            final confirm = await AppDialogs.showLogoutDialog();
            if (confirm == true) {
              Get.offAllNamed(AppRoutes.login);
            }
          },
          isDestructive: true,
        ),
      ],
    );
  }
}
