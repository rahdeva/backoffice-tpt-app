import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:backoffice_tpt_app/feature/main/main_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:sizer/sizer.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key, 
    required this.controller,
  }) : super(key: key);

  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 40.w,
      elevation: 0,
      surfaceTintColor: AppColors.background2,
      backgroundColor: AppColors.background2,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 24, 16, 24),
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.white
              ),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              children: [
                CachedNetworkImage(
                    imageUrl: controller.user?.profilePicture != ""
                      ? controller.user!.profilePicture!
                      : "https://ui-avatars.com/api/?size=120&name=${controller.user?.name ?? "User"}",
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 20,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => const CircleAvatar(
                      radius: 20,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://ui-avatars.com/api/?size=120&name=${controller.user?.name ?? "User"}"
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                Text(
                  controller.user?.name ?? "User",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.white.withOpacity(0.2)),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 24, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 0
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Home",
              icon: const Icon(
                IconlyBold.home,
                color: AppColors.white,
              ),
              press: () {
                controller.changeTabIndex(0);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 1
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "History",
              icon: const Icon(
                IconlyBold.activity,
                color: AppColors.white,
              ),
              press: () {
                controller.changeTabIndex(1);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 2
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Setting",
              icon: const Icon(
                IconlyBold.setting,
                color: AppColors.white,
              ),
              press: () {
                controller.changeTabIndex(2);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final Widget icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
