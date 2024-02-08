import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:sizer/sizer.dart';

class LabelFormWidget extends StatelessWidget {
  const LabelFormWidget({
    super.key, 
    required this.labelText,
    this.fontSize,
    this.fontWeight,
  });

  final String labelText;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(bottom: 12),
      child: Text(
        labelText,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: fontSize ?? 12,
          color: AppColors.black,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}

class LabelFormWidget2 extends StatelessWidget {
  const LabelFormWidget2({
    super.key,
    required this.label,
    this.labelColor
  });

  final String label;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 10.w - 16,
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: labelColor ?? AppColors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}