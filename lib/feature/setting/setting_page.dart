import 'package:backoffice_tpt_app/feature/setting/widgets/edit_profile_widget.dart';
import 'package:backoffice_tpt_app/feature/setting/widgets/profile_picture_reset_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/setting/setting_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/responsive.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:sizer/sizer.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(
      builder: (controller) {
        return SafeArea(
          child: Container(
            width: 100.w,
            height: 100.h,
            margin: const EdgeInsets.fromLTRB(24, 24, 0, 0),
            decoration: const BoxDecoration(
              color: AppColors.background2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!Responsive.isDesktop(context))
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      }
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                        height: 100.h-24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Setting",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 80.h-3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            const SizedBox(height: 24),
                                            PrimaryButtonWidget(
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.horizontal(
                                                    left: Radius.circular(10),
                                                    right: Radius.circular(0),
                                                  )
                                                ),
                                              ),
                                              customColors: controller.settingTabIndex == 0
                                                ? AppColors.background1
                                                : AppColors.black.withOpacity(0.2),
                                              margin: const EdgeInsets.all(0),
                                              buttonText: "Profile", 
                                              onPressed: () async {
                                                controller.changeTabIndex(0);
                                              },
                                              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                color: controller.settingTabIndex == 0
                                                  ? AppColors.white
                                                  : AppColors.white.withOpacity(0.5),
                                                fontWeight: FontWeight.w600
                                              )
                                            ),
                                            const SizedBox(height: 24),
                                            PrimaryButtonWidget(
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.horizontal(
                                                    left: Radius.circular(10),
                                                    right: Radius.circular(0),
                                                  )
                                                ),
                                              ),
                                              customColors: controller.settingTabIndex == 1
                                                ? AppColors.background1
                                                : AppColors.black.withOpacity(0.2),
                                              margin: const EdgeInsets.all(0),
                                              buttonText: "Device", 
                                              onPressed: () async {
                                                controller.changeTabIndex(1);
                                              },
                                              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                color: controller.settingTabIndex == 1
                                                  ? AppColors.white
                                                  : AppColors.white.withOpacity(0.5),
                                                fontWeight: FontWeight.w600
                                              )
                                            ),
                                          ],
                                        ),
                                        PrimaryButtonWidget(
                                          width: 10.w,
                                          customColors: AppColors.red,
                                          margin: const EdgeInsets.all(0),
                                          padding: 8,
                                          buttonText: "Logout", 
                                          withIcon: true,
                                          icon: const Icon(
                                            IconlyLight.logout,
                                            color: AppColors.white,
                                            size: 16,
                                          ),
                                          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                            color: AppColors.white,
                                            fontWeight: FontWeight.w600
                                          ),
                                          onPressed: () async {
                                            controller.logout();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: controller.settingTabIndex == 0
                                    ? Container(
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: AppColors.background1
                                        ),
                                        padding: const EdgeInsets.all(40),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            ProfilePictureResetPasswordWidget(
                                              controller: controller,
                                            ),
                                            const SizedBox(width: 24),
                                            EditProfileWidget(
                                              controller: controller,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 80.w,
                                        height: 80.h-3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: AppColors.background1
                                        ),
                                        // child: ,
                                      )
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}