import 'package:cached_network_image/cached_network_image.dart';
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
            margin: const EdgeInsets.fromLTRB(24, 40, 0, 0),
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
                        height: 100.h-40,
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
                                        height: 80.h-3,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: AppColors.background1
                                        ),
                                        padding: const EdgeInsets.all(40),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      border: Border.all(color: AppColors.white)
                                                    ),
                                                    padding: const EdgeInsets.all(24),
                                                    child: Column(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl: controller.user?.profilePicture != ""
                                                            ? controller.user!.profilePicture!
                                                            : "https://ui-avatars.com/api/?size=120&name=${controller.user?.name ?? "User"}",
                                                          imageBuilder: (context, imageProvider) => CircleAvatar(
                                                            radius: 100,
                                                            backgroundImage: imageProvider,
                                                          ),
                                                          placeholder: (context, url) => const CircleAvatar(
                                                            radius: 100,
                                                            child: Center(
                                                              child: CircularProgressIndicator(),
                                                            ),
                                                          ),
                                                          errorWidget: (context, url, error) => CircleAvatar(
                                                            radius: 100,
                                                            backgroundImage: NetworkImage(
                                                              "https://ui-avatars.com/api/?size=120&name=${controller.user?.name ?? "User"}"
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 24),
                                                        SizedBox(
                                                          width: 100.w,
                                                          child: PrimaryButtonWidget(
                                                            customColors: AppColors.primary,
                                                            margin: const EdgeInsets.all(0),
                                                            buttonText: "Change Profile Picture", 
                                                            withIcon: true,
                                                            padding: 12,
                                                            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                              color: AppColors.white,
                                                              fontWeight: FontWeight.w600
                                                            ),
                                                            onPressed: () async {
                                                              
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 24),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20),
                                                      border: Border.all(color: AppColors.white)
                                                    ),
                                                    padding: const EdgeInsets.all(24),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Reset Password",
                                                          textAlign: TextAlign.left,
                                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                            color: AppColors.white,
                                                            fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                        const SizedBox(height: 24),
                                                        SizedBox(
                                                          width: 100.w,
                                                          child: PrimaryButtonWidget(
                                                            customColors: AppColors.primary,
                                                            margin: const EdgeInsets.all(0),
                                                            buttonText: "Send to Email", 
                                                            withIcon: true,
                                                            padding: 12,
                                                            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                              color: AppColors.white,
                                                              fontWeight: FontWeight.w600
                                                            ),
                                                            onPressed: () async {
                                                              controller.sendPasswordResetEmail();
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: AppColors.white)
                                                ),
                                                padding: const EdgeInsets.all(24),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Edit Profile",
                                                      textAlign: TextAlign.left,
                                                      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                                        color: AppColors.white,
                                                        fontWeight: FontWeight.w700
                                                      ),
                                                    ),
                                                    const SizedBox(height: 24),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: PrimaryButtonWidget(
                                                        width: 12.w,
                                                        customColors: AppColors.primary,
                                                        margin: const EdgeInsets.all(0),
                                                        buttonText: "Edit Profile", 
                                                        withIcon: true,
                                                          padding: 12,
                                                          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                                            color: AppColors.white,
                                                            fontWeight: FontWeight.w600
                                                          ),
                                                        onPressed: () async {
                                                      
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
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
