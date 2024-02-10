import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:backoffice_tpt_app/feature/main/main_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                Flexible(
                  child: Text(
                    controller.user?.name ?? "User",
                    style: const TextStyle(
                      color: Colors.white,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: AppColors.white.withOpacity(0.2)),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 12, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 0
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Home",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: Icon(
                    IconlyBold.home,
                    color: AppColors.white,
                  ),
                ),
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
              title: "Setting",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: Icon(
                    IconlyBold.setting,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(1);
              },
            ),
          ),
          // Master Data
          const FeaturesDivider(title: "Master Data"),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 2
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Product",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.boxesStacked,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(2);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 3
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Category",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.box,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(3);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 4
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Supplier",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.truck,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(4);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 5
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "User",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.users,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(5);
              },
            ),
          ),
          // Report
          const FeaturesDivider(title: "Report"),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 6
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Sale",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.upload,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(6);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 7
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Purchase",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.download,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(7);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 8
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Financial",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.coins,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(8);
              },
            ),
          ),
          // Dashboard
          const FeaturesDivider(title: "Dashboard"),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 9
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Transaction",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.cartShopping,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(9);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 10
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Financial",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.wallet,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(10);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 4, 12, 8),
            decoration: BoxDecoration(
              color: controller.tabIndex == 11
                ? AppColors.primary
                : Colors.transparent,
              borderRadius: BorderRadius.circular(8)
            ),
            child: DrawerListTile(
              title: "Forecasting",
              icon: const SizedBox(
                height: 32,
                width: 32,
                child: Center(
                  child: Icon(
                    IconlyBold.work,
                    color: AppColors.white,
                  ),
                ),
              ),
              press: () {
                controller.changeTabIndex(11);
              },
            ),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}

class FeaturesDivider extends StatelessWidget {
  const FeaturesDivider({
    super.key,
    required this.title
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: AppColors.white.withOpacity(0.2)
            )
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: AppColors.white.withOpacity(0.6),
              fontWeight: FontWeight.w600
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Divider(
              color: AppColors.white.withOpacity(0.2)
            )
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
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 13,
          color: AppColors.white,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
