import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/notification/widgets/notification_list_builder.dart';
import 'package:backoffice_tpt_app/utills/widget/state/empty_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '/feature/notification/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return Scaffold(
          body: SmartRefresher(
            enablePullDown: true,
            controller: controller.refreshController,
            onRefresh: controller.refreshPage,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  (controller.isLoading)
                  ? const Center(child: CircularProgressIndicator())
                  : (controller.dataList.isEmpty)
                    ? const EmptyStateWidget()
                    : ListNotificationBuilder(
                        controller: controller
                      ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(onPressed: (){
            print("gas");
            controller.getAllNotification();
          }),
        );
      }
    );
  }
}
