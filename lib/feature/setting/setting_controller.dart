import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/model/user.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/snackbar/snackbar_widget.dart';
import '/feature/auth/auth_controller.dart';

class SettingController extends GetxController {
  final AuthController authController = AuthController.find;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserData? get user => authController.user;

  var settingTabIndex = 0;

  void changeTabIndex(int index) {
    settingTabIndex = index;
    update();
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      await authController.signOut();
    } catch (e) {
      Get.snackbar(
        "TERJADI KESALAHAN", 
        "Tidak dapat logout."
      );
    }
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await auth.sendPasswordResetEmail(
        email: user?.email ?? "-"
      );
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.check_circle,
          color: AppColors.green,
        ),
        title: "BERHASIL",
        subtitle: "Password reset email sent to ${user?.email ?? "-"}"
      );
    } catch (e) {
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Oops!",
        subtitle: "Error sending password reset email: ${user?.email ?? "-"}"
      );
    }
  }
}
