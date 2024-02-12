import 'package:backoffice_tpt_app/feature/category/category_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class EditCategoryButton extends StatelessWidget {
  const EditCategoryButton({
    super.key,
    required this.categoryId,
    required this.controller,
  });

  final int categoryId;
  final CategoryController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.orange,
      margin: const EdgeInsets.all(0),
      buttonText: "Edit", 
      withIcon: true,
      onPressed: () {
        controller.getCategoryDetail(
          categoryId : categoryId,
          isEdit: true 
        );
        PopUpWidget.inputPopUp(
          context: context,
          width: 60.w,
          titleString: "Edit Produk", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.editCategoryFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [  
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Kode Kategori"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'category_code',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.text,
                        borderRadius: 10,
                        contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Nama Kategori"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'category_name',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.text,
                        borderRadius: 10,
                        contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Warna Kategori"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'category_color',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.text,
                        borderRadius: 10,
                        contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
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
                  margin: const EdgeInsets.only(right: 0),
                  alignment: Alignment.centerRight,
                  child: PrimaryButtonWidget(
                    customColors: AppColors.green,
                    margin: const EdgeInsets.all(0),
                    buttonText: "Save", 
                    withIcon: true,
                    icon: const FaIcon(
                      FontAwesomeIcons.floppyDisk,
                      color: AppColors.white,
                      size: 16,
                    ), 
                    onPressed: () {
                      if(
                        controller.editCategoryFormKey.currentState != null &&
                        controller.editCategoryFormKey.currentState!.saveAndValidate()
                      ){
                        controller.updateCategory(
                          categoryId: categoryId,
                          categoryCode: controller.editCategoryFormKey.currentState!.fields['category_code']!.value, 
                          categoryName: controller.editCategoryFormKey.currentState!.fields['category_name']!.value, 
                          categoryColor: controller.editCategoryFormKey.currentState!.fields['category_color']!.value, 
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
