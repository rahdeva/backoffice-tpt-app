import 'package:backoffice_tpt_app/data/remote/dio.dart';
import 'package:backoffice_tpt_app/data/remote/endpoint.dart';
import 'package:backoffice_tpt_app/utills/helper/loading_helper.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/model/user.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/snackbar/snackbar_widget.dart';
import '/feature/auth/auth_controller.dart';

class SettingController extends GetxController {
  final AuthController authController = AuthController.find;
  final GlobalKey<FormBuilderState> editUserFormKey = GlobalKey<FormBuilderState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserData? get user => authController.user;

  var settingTabIndex = 0;

  void changeTabIndex(int index) {
    settingTabIndex = index;
    update();
  }

  // Future<void> refreshPage() async {
  //   dataList.clear();
  //   page.value = 1;
  //   pageSize.value = 10;
  //   searchformKey.currentState?.reset();
  //   searchKeyword.value = "";
  //   tableKey.currentState?.pageTo(1);
  //   await getAllUsers();
  //   update();
  // }

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

  Future<void> sendPasswordResetEmail(
    BuildContext context
  ) async {
    try {
      await auth.sendPasswordResetEmail(
        email: user?.email ?? "-"
      );
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Password reset email sent to ${user?.email ?? "-"}", 
        buttonText: "OK"
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

  void editProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required BuildContext context,
  }) async {
    showLoading();
    final dio = await AppDio().getDIO();

    try {
      final userData = await dio.put(
        BaseUrlLocal.user,
        data: {
          "user_id": user?.userId,
          "name": name,
          "email": email,
          "address": address,
          "phone_number": phoneNumber,
        },
      );
      debugPrint('Edit User: ${userData.data}');
      dismissLoading();
      Get.back();
      // ignore: use_build_context_synchronously
      PopUpWidget.successAndFailPopUp(
        context: context, 
        titleString: "Success!", 
        middleText: "Edit profile berhasil.", 
        buttonText: "OK"
      );
      // await refreshPage();
      // Update current user data
    } on DioError catch (error) {
      dismissLoading();
      SnackbarWidget.defaultSnackbar(
        icon: const Icon(
          Icons.cancel,
          color: AppColors.red,
        ),
        title: "Error!",
        subtitle: "${error.response!.statusCode.toString()} - ${error.response!.statusMessage.toString()}",
      );
      debugPrint(error.toString());
    }
  }
}
