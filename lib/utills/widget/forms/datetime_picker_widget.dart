import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

import '../../../resources/resources.dart';

class DateTimePickerWidget extends StatelessWidget {
  const DateTimePickerWidget({
    Key? key,
      required this.name,
      this.hintText,
      this.label,
      this.onChanged,
      this.suffixIcon = const Icon(Icons.date_range),
      this.enabled = true,
      this.filled = false,
      this.borderRadius = 4,
      this.firstDate,
      this.lastDate,
      this.currentDate,
      this.initialDate,
      this.inputType = InputType.date, 
      this.validator, 
      this.hintStyle, 
      this.textStyle, 
      this.contentPadding
  })  : super(key: key);

  final String name;
  final String? hintText;
  final bool enabled;
  final bool filled;
  final InputType inputType;
  final double borderRadius;
  final String? label;
  final Widget? suffixIcon;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? currentDate;
  final DateTime? initialDate;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(DateTime?)? onChanged;
  final String? Function(DateTime?)? validator;

  @override
  Widget build(BuildContext context) {
    return FormBuilderDateTimePicker(
      format: inputType == InputType.both
        ? DateFormat("dd/MM/yyyy HH:mm")
        : inputType == InputType.time
          ? DateFormat.Hm()
          : DateFormat('dd/MM/yyyy'),
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      enabled: enabled,
      initialDate: initialDate,
      inputType: inputType,
      name: name,
      onChanged: onChanged,
      validator: validator,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w400
      ),
      decoration: InputDecoration(
        fillColor: enabled 
          ? filled
            ? AppColors.white
            : Colors.transparent
          : AppColors.gray500,
        labelText: label,
        hintText: hintText,
        isDense: true,
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(12,16,12,16), 
        suffixIcon: suffixIcon,
        hintStyle: hintStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.gray500
        ),
        labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600
        ),
        errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.red
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: AppColors.primary, 
            width: 1
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: AppColors.primary, 
            width: 1
          )
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: AppColors.primary, 
            width: 1
          )
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppColors.red.withOpacity(0.8), 
            width: 1
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: AppColors.primary, 
            width: 2
          )
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: AppColors.red, 
            width: 1.5
          ),
        ),
      ),
      transitionBuilder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.colorPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
  }
}
