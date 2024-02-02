import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';

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