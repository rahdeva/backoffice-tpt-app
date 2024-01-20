import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/bottom_nav_bar/widgets/sm_bottom_navbar_item.dart';
import 'package:backoffice_tpt_app/feature/my_employee/my_employee_page.dart';
import 'package:backoffice_tpt_app/feature/notification/notification_page.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import '/feature/home/home_page.dart';
import '/feature/profile/profile_page.dart';

import 'nav_tab_controller.dart';

class NavTabPage extends StatelessWidget {
  const NavTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavTabController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: const [
                HomePage(),
                MyEmployeePage(),
                NotificationPage(),
                ProfilePage(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                color: Colors.grey,
                border: Border(
                  top: BorderSide(color: Colors.white, width: 1.0
                )
              )
            ),
            child: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 5,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SMBottomNavBarItem(
                    imageDeactive: AppImages.icHomeUnactive.image(),
                    imageActive: AppImages.icHomeActive.image(),
                    currentIndex: controller.tabIndex,
                    onTap: controller.changeTabIndex,
                    label: 'txt_menu_home'.tr,
                    index: 0,
                  ),
                  SMBottomNavBarItem(
                    imageDeactive: AppImages.icActivityUnactive.image(),
                    imageActive: AppImages.icActivityActive.image(),
                    currentIndex: controller.tabIndex,
                    onTap: (value) {
                      controller.changeTabIndex(value);
                    },
                    label: 'txt_menu_my_activity'.tr,
                    index: 1,
                  ),
                  SMBottomNavBarItem(
                    imageDeactive: AppImages.icNotifUnactive.image(),
                    imageActive: AppImages.icNotifActive.image(),
                    currentIndex: controller.tabIndex,
                    onTap: controller.changeTabIndex,
                    label: 'txt_menu_notification'.tr,
                    index: 2,
                  ),
                  SMBottomNavBarItem(
                    imageDeactive: AppImages.icProfileUnactive.image(),
                    imageActive: AppImages.icProfileActive.image(),
                    currentIndex: controller.tabIndex,
                    onTap: (value) {
                      controller.changeTabIndex(value);
                    },
                    label: 'txt_menu_profile'.tr,
                    index: 3,
                  ),
                ],
              ),
            )
          ),
        );
      },
    );
  }
}