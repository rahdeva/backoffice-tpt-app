import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.controller,
    required this.icon,
    this.color,
    required this.onPressed,
  });

  final GetxController controller;
  final Widget icon;
  final Color? color;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          color ?? AppColors.primary,
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )
        )
      ),
      onPressed: onPressed,
      child: Center(
        child: icon
      )
    );
  }
}