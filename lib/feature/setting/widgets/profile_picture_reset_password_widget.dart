import 'package:backoffice_tpt_app/feature/setting/setting_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfilePictureResetPasswordWidget extends StatelessWidget {
  const ProfilePictureResetPasswordWidget({
    super.key, 
    required this.controller,
  });

  final SettingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                      controller.pickImage(context: context);
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
                      controller.sendPasswordResetEmail(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
