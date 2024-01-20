import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/resources/resources.dart';

class SnackbarWidget{
  static void defaultSnackbar({
    RxBool? isDissmiss, 
    required Widget icon,
    required String title, 
    required String subtitle, 
  }){
    Get.snackbar(
      title,
      subtitle,
      snackPosition: SnackPosition.BOTTOM,
      icon: icon,
      backgroundColor: AppColors.white,
      borderRadius: 12,
      margin: const EdgeInsets.all(20),
      colorText: AppColors.black,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      snackbarStatus: (status) => status == SnackbarStatus.CLOSED
          ? isDissmiss?.value = false
          : isDissmiss?.value = true,
      boxShadows: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.10),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 2),
        )
      ]
    );
  }
}

