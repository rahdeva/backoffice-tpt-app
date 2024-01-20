import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/home/home_page.dart';
import 'package:backoffice_tpt_app/feature/my_employee/my_employee_page.dart';
import 'package:backoffice_tpt_app/feature/notification/notification_page.dart';
import 'package:backoffice_tpt_app/feature/profile/profile_page.dart';
import '/feature/bottom_nav_bar/nav_tab_binding.dart';
import '/feature/bottom_nav_bar/nav_tab_page.dart';
import '/feature/loader/loading_page.dart';
import '/feature/login/login_binding.dart';
import '/feature/login/login_page.dart';

import 'page_names.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: PageName.LOADER,
      page: () => const LoadingPage(),
    ),
    GetPage(
      name: PageName.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: PageName.NAVTAB,
      page: () => const NavTabPage(),
      binding: NavTabBinding()
    ),
    GetPage(
      name: PageName.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: PageName.MY_EMPLOYEE,
      page: () => const MyEmployeePage(),
    ),
    GetPage(
      name: PageName.NOTIFICATION,
      page: () => const NotificationPage(),
    ),
    GetPage(
      name: PageName.PROFILE,
      page: () => const ProfilePage(),
    ),
  ];
}
