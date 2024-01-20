import 'package:flutter/material.dart';
import '/resources/resources.dart';
import 'package:sizer/sizer.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget({
    super.key, 
    required this.buttonText, 
    required this.onPressed, 
    this.width, 
    this.borderRadius, 
    this.margin, 
    this.padding, 
    this.customColors, 
    this.height,
    this.smallText = false,
  });

  final String buttonText;
  final double? width;
  final double? height;
  final Color? customColors;
  final double? borderRadius;
  final double? padding;
  final bool smallText;
  final EdgeInsetsGeometry? margin;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 100.w,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            customColors ?? AppColors.blue,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 10),
            )
          )
        ),
        onPressed: onPressed, 
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: padding ?? 12),
          child: Text(
            buttonText,
            textAlign: TextAlign.center,
            style: smallText
            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600
              )
            : Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600
              )
          ),
        )
      ),
    );
  }
}