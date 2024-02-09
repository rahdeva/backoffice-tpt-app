import 'package:backoffice_tpt_app/feature/user/user_controller.dart';
import 'package:backoffice_tpt_app/model/role.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/dropdown_search_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_area_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EditUserButton extends StatelessWidget {
  const EditUserButton({
    super.key,
    required this.userId,
    required this.controller,
  });

  final int userId;
  final UserController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.orange,
      margin: const EdgeInsets.all(0),
      buttonText: "Edit", 
      withIcon: true,
      onPressed: () {
        controller.getRoles();
        controller.getUserDetail(
          userId : userId,
          isEdit: true 
        );
        PopUpWidget.inputPopUp(
          context: context,
          width: 60.w,
          titleString: "Edit User", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.editUserFormKey,
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
                      label: "Nama User"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'name',
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
                      label: "Role"
                    ),
                    GetBuilder(
                      id: 'edit-role-dropdown',
                      init: controller,
                      builder: (_) {
                        return SizedBox(
                          width: 50.w - 16,
                          child: DropdownSearchWidget<Role>(
                            hintText: "",
                            validator: Validator.required(),
                            asyncItems: (filter) => controller.getRoles(),
                            onChanged: (Role? newValue){
                              controller.editRoleResult = newValue;
                            },
                            borderRadius: 10,
                            selectedItem: controller.editRoleResult,
                            contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
                            itemAsString: (Role role) => role.roleName ?? "-",
                            itemBuilder: (context, item, isSelected) {
                              return ListTile(
                                title: Text(
                                  item.roleName ?? "-",
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black,
                                  ),
                                ),
                              );
                            },
                            textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Email"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        enabled: false,
                        name: 'email',
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
                      label: "No Telepon"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'phone_number',
                        hintText: "",
                        validator: Validator.list([
                            Validator.numeric(),
                            Validator.required()
                          ]),  
                        keyboardType: TextInputType.number,
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
                      label: "Alamat"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextAreaWidget(
                        name: "address", 
                        hintText: "", 
                        textAreaResultC: controller.editAddressResult, 
                        maxLength: 200,
                        borderRadius: 10,
                        validator: Validator.list([
                          Validator.required(),
                          Validator.maxLength(200),
                        ]),
                        onChanged: (newVal) {
                          if (newVal != "") {
                            controller.editAddressResult.value = newVal!;
                          }
                        }, 
                        keyboardType: TextInputType.text,
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
                        controller.editUserFormKey.currentState != null &&
                        controller.editUserFormKey.currentState!.saveAndValidate()
                      ){
                        controller.updateUser(
                          userId: userId,
                          name: controller.editUserFormKey.currentState!.fields['name']!.value, 
                          roleId: controller.editUserFormKey.currentState!.fields['role_id']!.value, 
                          email: controller.editUserFormKey.currentState!.fields['email']!.value, 
                          phoneNumber: controller.editUserFormKey.currentState!.fields['phone_number']!.value, 
                          address: controller.editUserFormKey.currentState!.fields['address']!.value, 
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
