import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/feature/notification/notification_controller.dart';
import 'package:backoffice_tpt_app/feature/notification/widgets/notification_items.dart';

class ListNotificationBuilder extends StatelessWidget {
  const ListNotificationBuilder({
    Key? key, 
    required this.controller, 
  }) : super(key: key);

  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.dataList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return NotificationListItem(
          index: index,
          controller: controller,
          mData: controller.dataList[index],
        );
      },
    );
  }
}
