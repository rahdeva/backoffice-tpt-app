import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/themes/app_theme.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class PopUpWidget{
  // Default Pop Up
  static Future<dynamic> defaultPopUp({
    required BuildContext context,
    required String titleString, 
    bool withMiddleText = true, 
    String? middleText, 
    double? width, 
    Widget? content, 
  }) {
    return Get.defaultDialog(
      backgroundColor: AppColors.white,
      radius : 8,
      title: titleString,
      titleStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w700
      ),
      titlePadding: const EdgeInsets.only(top: 40),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      content: SizedBox(
        width: width ?? 100.w,
        child: withMiddleText == true
          ? Column(
              children: [
                Text(
                  middleText ?? "-",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black
                  ),
                ),
                content ?? const SizedBox(),
              ],
            )
          : content ?? const SizedBox()
      ),
    );
  }
  
  // Default Pop Up
  static Future<void> inputPopUp({
    required BuildContext context,
    required String titleString, 
    bool withMiddleText = true, 
    String? middleText, 
    double? width, 
    Widget? content, 
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.only(top: 40),
          contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          backgroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          title: Text(
            titleString, 
            textAlign: TextAlign.center, 
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700
            ),
          ),
          content: Theme(
            data: AppTheme.buildThemeData(true, context).copyWith(
              scrollbarTheme: const ScrollbarThemeData().copyWith(
                thumbColor: MaterialStateProperty.all(AppColors.background2),
              ),
            ),
            child: Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(right: 24),
                  child: content
                )
              ),
            ),
          ),
          buttonPadding: EdgeInsets.zero,
        );
      }
    );
  }

  // Success and Fail PopUp
  static Future<dynamic> successAndFailPopUp({
    required BuildContext context,
    required String titleString, 
    required String middleText, 
    required String buttonText,
    bool isSuccess = true,
    Function()? buttonOnPressed,
    textAreaResult
  }) {
    return Get.defaultDialog(
      backgroundColor: AppColors.white,
      radius : 8,
      title: "",
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      content: SizedBox(
        width: 25.w,
        child: Column(
          children: [
            Lottie.asset(
              isSuccess 
                ? AppImages.lottieSuccess 
                : AppImages.lottieFailed,
              repeat: false,
              width: 15.w
            ),
            const SizedBox(height: 8),
            Text(
              titleString,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.black
              ),
            ),
            const SizedBox(height: 24),
            Text(
              middleText,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButtonWidget(
              buttonText: buttonText,
              onPressed: buttonOnPressed ?? () => Get.back()
            ),
          ],
        ),
      ),
    );
  }

  // Confirmation PopUp
  static Future<dynamic> confirmationPopUp({
    required BuildContext context,
    required String titleString, 
    required String popUpConfirmText, 
    required String popUpCancelText, 
    String? textAreaHintText, 
    required Function() confirmOnPress,
    Function()? cancelOnPress,
    RxString? textAreaResultC,
  }) {
    return Get.defaultDialog(
      backgroundColor: AppColors.white,
      radius : 8,
      title: "",
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      content: SizedBox(
        width: 30.w,
        child: Column(
          children: [
            const Icon(
              Icons.info,
              color: Colors.orange,
              size: 80,
            ),
            const SizedBox(height: 8),
            Text(
              titleString,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: AppColors.black
              ),
            ),
            const SizedBox(height: 40),
            textAreaHintText == null && textAreaResultC == null
            ? const SizedBox()
            : TextAreaWidget(
                name: "verifikasi", 
                hintText: textAreaHintText!, 
                textAreaResultC: textAreaResultC!, 
                maxLength: 200,
                validator: Validator.list([
                  Validator.required(),
                  Validator.maxLength(200),
                ]),
                onChanged: (newVal) {
                  if (newVal != "") {
                    textAreaResultC.value = newVal!;
                  }
                }, 
              ),
            const SizedBox(height: 24),
            SizedBox(
              width: 30.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryButtonWidget(
                    buttonText: popUpConfirmText,
                    margin: const EdgeInsets.all(0),
                    width: 20.w - 84,
                    customColors: AppColors.red,
                    onPressed: confirmOnPress
                  ),
                  const SizedBox(width: 16),
                  PrimaryButtonWidget(
                    buttonText: popUpCancelText,
                    margin: const EdgeInsets.all(0),
                    width: 20.w - 84,
                    customColors: AppColors.grey,
                    onPressed: cancelOnPress ?? () => Get.back()
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}