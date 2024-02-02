import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/model/user.dart';

import '/feature/auth/auth_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  static MainController find = Get.find();
  final AuthController authController = AuthController.find;
  UserData? get user => authController.user;
  var tabIndex = 0;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }
}

