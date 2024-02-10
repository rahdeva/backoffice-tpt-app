import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '/resources/resources.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.name,
    this.hintText,
    this.initialValue,
    this.label,
    this.enabled = true,
    this.filled = false,
    this.obsecure = false,
    this.keyboardType = TextInputType.text,
    this.borderRadius = 4,
    this.onChanged,
    this.fillColor,
    this.validator, 
    this.suffixIcon, 
    this.prefixIcon,
    this.floatingLabelBehavior, 
    this.contentPadding, 
    this.hintStyle, 
    this.textStyle, 
    this.inputFormatters, 
  }) : super(key: key);

  final String name;
  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool enabled;
  final bool filled;
  final Color? fillColor;
  final bool obsecure;
  final String? initialValue;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      name: name,
      enabled: enabled,
      obscureText: obsecure,
      initialValue: initialValue,
      validator: validator,
      keyboardType: keyboardType,
      onChanged: onChanged,
      autocorrect: false,
      style: textStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(
        color: AppColors.black,
        fontWeight: FontWeight.w400
      ),
      decoration: InputDecoration(
        fillColor: fillColor ?? (
            (enabled) 
              ? filled
                ? AppColors.white
                : Colors.transparent
              : AppColors.gray500
          ),
        labelText: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: true,
        floatingLabelBehavior: floatingLabelBehavior,
        contentPadding: contentPadding ?? const EdgeInsets.fromLTRB(12,16,12,16), 
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
    );
  }
}
