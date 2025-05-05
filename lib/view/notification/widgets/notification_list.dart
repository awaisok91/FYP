import 'package:e_learning/view/notification/widgets/noticfication_card.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return NoticficationCard(
          title: 'New Course Available',
          message: 'Check out our new flutter course',
          time: '10:30 AM',
          icon: Icons.school,
          isUnread: index == 0,
        );
      },
    );
  }
}
