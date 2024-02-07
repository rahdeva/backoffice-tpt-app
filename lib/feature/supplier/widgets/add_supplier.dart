import 'package:backoffice_tpt_app/feature/supplier/supplier_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sizer/sizer.dart';

class AddSupplierButton extends StatelessWidget {
  const AddSupplierButton({
    super.key,
    required this.controller,
  });

  final SupplierController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.yellow,
      margin: const EdgeInsets.all(0),
      buttonText: "Tambah Supplier", 
      withIcon: true,
      icon: const Icon(
        IconlyLight.plus,
        color: AppColors.white,
        size: 16,
      ), 
      onPressed: () {
        PopUpWidget.defaultPopUp(
          context: context,
          width: 60.w,
          titleString: "Tambah Supplier", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.addSupplierFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [  
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Nama Supplier"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'supplier_name',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.text,
                        borderRadius: 10,
                        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "No Telepon"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'phone_number',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.text,
                        borderRadius: 10,
                        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Alamat"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'address',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.text,
                        borderRadius: 10,
                        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  alignment: Alignment.centerRight,
                  child: PrimaryButtonWidget(
                    customColors: AppColors.yellow,
                    margin: const EdgeInsets.all(0),
                    buttonText: "Tambah", 
                    withIcon: true,
                    icon: const Icon(
                      IconlyLight.plus,
                      color: AppColors.white,
                      size: 16,
                    ), 
                    onPressed: () {
                      if(
                        controller.addSupplierFormKey.currentState != null &&
                        controller.addSupplierFormKey.currentState!.saveAndValidate()
                      ){
                        controller.addNewSupplier(
                          supplierName: controller.addSupplierFormKey.currentState!.fields['supplier_name']!.value, 
                          phoneNumber: controller.addSupplierFormKey.currentState!.fields['phone_number']!.value, 
                          address: controller.addSupplierFormKey.currentState!.fields['address']!.value, 
                          context: context
                        );
                      }
                    }
                  ),
                )
              ],
            ),
          )
        );
      },
    );
  }
}
