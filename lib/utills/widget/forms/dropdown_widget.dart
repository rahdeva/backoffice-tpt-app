import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../../resources/resources.dart';

class DropdownWidget<T> extends StatelessWidget {
  const DropdownWidget({
    Key? key,
    required this.hintText,
    required this.selectedItem,
    required this.onChanged,
    this.label,
    this.enabled = true,
    this.showSearchBox = false,
    this.borderRadius = 4,
    this.hintStyle,
    this.validator, 
    this.items, 
    this.asyncItems, 
    this.itemBuilder, 
    this.itemAsString, 
    this.contentPadding,
    this.textStyle,
  }) : super(key: key);

  final String hintText;
  final String? label;
  final bool enabled;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final double borderRadius;
  final bool showSearchBox;
  final EdgeInsetsGeometry? contentPadding;
  final T? selectedItem;
  final Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final List<T>? items;
  final Future<List<T>> Function(String)? asyncItems;
  final Widget Function(BuildContext, T, bool)? itemBuilder;
  final String Function(T)? itemAsString;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      autoValidateMode: AutovalidateMode.onUserInteraction,
      clearButtonProps: const ClearButtonProps(isVisible: true),
      validator: validator,
      selectedItem: selectedItem,
      enabled: enabled,
      onChanged: onChanged,
      items: items ?? [],
      asyncItems: asyncItems,
      itemAsString: itemAsString,
      popupProps: PopupProps.menu(
        isFilterOnline: false,
        showSearchBox: showSearchBox,
        fit: FlexFit.loose,
        constraints: const BoxConstraints(maxHeight: 300),
        itemBuilder: itemBuilder,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            isDense: true,
            fillColor: enabled 
              ? Colors.transparent
              : AppColors.gray500,
            hintText: hintText,
            labelText: label,
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
          )
        ),
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: textStyle ?? Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: AppColors.black,
        ),
        textAlignVertical: TextAlignVertical.center,
        dropdownSearchDecoration: InputDecoration(
          isDense: true,
          fillColor: enabled 
            ? Colors.transparent
            : AppColors.gray500,
          hintText: hintText,
          labelText: label,
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
      ),
      dropdownButtonProps: const DropdownButtonProps(
        icon: Icon(
          Icons.keyboard_arrow_down,
          size: 22,
          color: AppColors.black,
        ),
      ),
    );
  }
}