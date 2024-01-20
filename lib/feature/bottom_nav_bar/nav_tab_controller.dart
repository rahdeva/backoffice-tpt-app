import '/feature/auth/auth_controller.dart';
import 'package:get/get.dart';

class NavTabController extends GetxController {
  static NavTabController find = Get.find();
  var tabIndex = 0;
  final AuthController authController = AuthController.find;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}

