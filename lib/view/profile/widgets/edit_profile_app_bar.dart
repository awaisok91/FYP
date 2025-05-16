import 'package:e_learning/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class EditProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSave;
  const EditProfileAppBar({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "Edit Profile",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: AppColors.primary,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        TextButton(
          onPressed: onSave,
          child: const Text(
            "Save",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
