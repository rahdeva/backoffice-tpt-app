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
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DeleteUserButton extends StatelessWidget {
  const DeleteUserButton({
    super.key,
    required this.userId,
    required this.controller,
  });

  final int userId;
  final UserController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.red,
      margin: const EdgeInsets.all(0),
      buttonText: "Delete", 
      withIcon: true,
      icon: const Icon(
        IconlyLight.delete,
        color: AppColors.white,
        size: 16,
      ), 
      onPressed: () {
        controller.getUserDetail(
          userId : userId,
          isEdit: false
        );
        PopUpWidget.inputPopUp(
          context: context,
          width: 60.w,
          titleString: "Delete User", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.deleteUserFormKey,
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
                        enabled: false,
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
                      id: 'delete-role-dropdown',
                      init: controller,
                      builder: (_) {
                        return SizedBox(
                          width: 50.w - 16,
                          child: DropdownSearchWidget<Role>(
                            enabled: false,
                            hintText: "",
                            validator: Validator.required(),
                            asyncItems: (filter) => controller.getRoles(),
                            onChanged: (Role? newValue){
                              controller.deleteRoleResult = newValue;
                            },
                            borderRadius: 10,
                            selectedItem: controller.deleteRoleResult,
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
                        enabled: false,
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
                        enabled: false,
                        name: "address", 
                        hintText: "", 
                        textAreaResultC: controller.deleteAddressResult, 
                        maxLength: 200,
                        borderRadius: 10,
                        validator: Validator.list([
                          Validator.required(),
                          Validator.maxLength(200),
                        ]),
                        onChanged: (newVal) {
                          if (newVal != "") {
                            controller.deleteAddressResult.value = newVal!;
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
                    customColors: AppColors.red,
                    margin: const EdgeInsets.all(0),
                    buttonText: "Delete", 
                    withIcon: true,
                    icon: const Icon(
                      IconlyLight.delete,
                      color: AppColors.white,
                      size: 16,
                    ), 
                    onPressed: () {
                      if(
                        controller.deleteUserFormKey.currentState != null &&
                        controller.deleteUserFormKey.currentState!.saveAndValidate()
                      ){
                        PopUpWidget.confirmationPopUp(
                          context: context, 
                          titleString: "Are you sure to delete?", 
                          popUpConfirmText: "Delete", 
                          popUpCancelText: "Cancel",  
                          confirmOnPress: (){
                            controller.deleteUser(
                              userId: userId,
                              context: context
                            );
                          }, 
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
