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

class AddUserButton extends StatelessWidget {
  const AddUserButton({
    super.key,
    required this.controller,
  });

  final UserController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.yellow,
      margin: const EdgeInsets.all(0),
      buttonText: "Tambah User", 
      withIcon: true,
      icon: const Icon(
        IconlyLight.plus,
        color: AppColors.white,
        size: 16,
      ), 
      onPressed: () {
        PopUpWidget.inputPopUp(
          context: context,
          width: 60.w,
          titleString: "Tambah User", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.addUserFormKey,
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
                    SizedBox(
                      width: 50.w - 16,
                      child: DropdownSearchWidget<Role>(
                        hintText: "",
                        validator: Validator.required(),
                        asyncItems: (filter) => controller.getRoles(),
                        onChanged: (Role? newValue){
                          controller.roleResult = newValue;
                        },
                        showSearchBox: false,
                        borderRadius: 10,
                        selectedItem: controller.roleResult,
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
                        textAreaResultC: controller.addAddressResult, 
                        maxLength: 200,
                        borderRadius: 10,
                        validator: Validator.list([
                          Validator.required(),
                          Validator.maxLength(200),
                        ]),
                        onChanged: (newVal) {
                          if (newVal != "") {
                            controller.addAddressResult.value = newVal!;
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Password"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: Obx(
                        () => TextFieldWidget(
                          name: 'password',
                          hintText: "",
                          obsecure: controller.isObscure.value,
                          validator: Validator.list([
                            Validator.required(),
                            Validator.password(),
                          ]),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          keyboardType: TextInputType.text,
                          borderRadius: 10,
                          textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w400
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.isObscure.value = !controller.isObscure.value;
                              controller.update();
                            },
                            icon: controller.isObscure.value
                              ? const Icon(
                                  Icons.visibility_outlined,
                                  color: AppColors.primary,
                                )
                              : const Icon(
                                  Icons.visibility_off_outlined,
                                  color: AppColors.primary,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
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
                        controller.addUserFormKey.currentState != null &&
                        controller.addUserFormKey.currentState!.saveAndValidate()
                      ){
                        controller.addNewUser(
                          roleId: controller.roleResult!.roleId!,
                          name: controller.addUserFormKey.currentState!.fields['name']!.value,
                          email: controller.addUserFormKey.currentState!.fields['email']!.value,
                          phoneNumber: controller.addUserFormKey.currentState!.fields['phone_number']!.value, 
                          address: controller.addUserFormKey.currentState!.fields['address']!.value, 
                          password: controller.addUserFormKey.currentState!.fields['password']!.value, 
                          context: context
                        );
                      }
                    }
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          )
        );
      },
    );
  }
}
