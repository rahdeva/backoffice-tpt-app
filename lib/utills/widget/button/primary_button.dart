import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
    this.shape, 
    this.textStyle, 
    this.withIcon = false, 
    this.icon, 
    this.height,
  });

  final String buttonText;
  final double? width;
  final double? height;
  final Color? customColors;
  final double? borderRadius;
  final double? padding;
  final TextStyle? textStyle;
  final bool withIcon;
  final Widget? icon;
  final MaterialStateProperty<OutlinedBorder?>? shape;
  final EdgeInsetsGeometry? margin;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return withIcon
    ? ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon ?? const Icon(
          IconlyLight.editSquare,
          color: AppColors.white,
          size: 16,
        ),
        label: Padding(
          padding: EdgeInsets.symmetric(vertical: padding ?? 0),
          child: Text(
            buttonText,
            style: textStyle ?? Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
              color: AppColors.white,
              fontWeight: FontWeight.w600
            ),
          ),
        ), //label text 
        style: ElevatedButton.styleFrom(
          backgroundColor: customColors ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      )
    : Container(
      width: width ?? 100.w,
      height: height,
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            customColors ?? AppColors.primary,
          ),
          shape: shape ?? MaterialStateProperty.all<RoundedRectangleBorder>(
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
              style: textStyle ?? Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600
              )
            ),
        )
      ),
    );
  }
}