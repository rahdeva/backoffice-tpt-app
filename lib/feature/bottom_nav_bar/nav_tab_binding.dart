import 'package:get/get.dart';
import '/feature/my_employee/my_employee_controller.dart';
import '/feature/notification/notification_controller.dart';
import '/feature/bottom_nav_bar/nav_tab_controller.dart';
import '/feature/home/home_controller.dart';
import '/feature/profile/profile_controller.dart';
// import 'package:emc_mobile_flutter/feature/home/section/carousel_banner/controller/carousel_banner_controller.dart';

class NavTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavTabController>(() => NavTabController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<MyEmployeeController>(() => MyEmployeeController());
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}