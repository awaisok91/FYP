import 'package:e_learning/core/theme/app_colors.dart';
import 'package:e_learning/view/notification/widgets/notification_setting_tile.dart';
import 'package:flutter/material.dart';

class NotificationSettingSection extends StatelessWidget {
  const NotificationSettingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          NotificationSettingTile(
            title: 'Push Notification',
            subtitle: "Receive push notification",
            icon: Icons.notifications,
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
          _buildDivider(),
           NotificationSettingTile(
            title: 'Course Update',
            subtitle: "Get notification about course update",
            icon: Icons.school_outlined,
            trailing: Switch(
              value: true,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
           NotificationSettingTile(
            title: 'Quiz Reminders',
            subtitle: "Recevier quiz deadline reminder",
            icon: Icons.quiz_outlined,
            trailing: Switch(
              value: false,
              onChanged: (value) {},
              activeColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: AppColors.primary.withOpacity(0.1),
      height: 1,
    );
  }
}
