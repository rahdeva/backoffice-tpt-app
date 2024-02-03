import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({
    Key? key,
    required this.name,
    required this.hintText,
    this.initialValue,
    this.label,
    this.enabled = true,
    this.minLines = 12, 
    this.maxLines = 20,
    this.keyboardType = TextInputType.multiline,
    this.onChanged,
    this.validator, 
    this.suffixIcon, 
    required this.textAreaResultC,
    required this.maxLength, 
  }) : super(key: key);

  final String name;
  final String hintText;
  final int maxLength;
  final String? label;
  final Widget? suffixIcon;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final RxString textAreaResultC;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 100.w,
          height: 120,
          child: FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            name: name,
            enabled: enabled,
            initialValue: initialValue,
            validator: validator,
            keyboardType: keyboardType,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
            autocorrect: false,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w400
            ),
            decoration: InputDecoration(
              fillColor: enabled 
                ? Colors.transparent
                : AppColors.grey,
              labelText: label,
              hintText: hintText,
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16, 
                horizontal: 12
              ), 
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey
              ),
              labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.colorPrimary,
                fontWeight: FontWeight.w600
              ),
              errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.red
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: Obx(
            () => Text(
              "${textAreaResultC.value.length}/$maxLength",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey
              ),
            ),
          ),
        ),
      ],
    );
  }
}
