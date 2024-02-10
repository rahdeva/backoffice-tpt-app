import 'package:backoffice_tpt_app/feature/setting/setting_controller.dart';
import 'package:backoffice_tpt_app/model/role.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/dropdown_search_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sizer/sizer.dart';

class EditProfileWidget extends StatelessWidget {
  const EditProfileWidget({
    super.key, 
    required this.controller,
  });

  final SettingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: FormBuilder(
        key: controller.editUserFormKey,
        child: GetBuilder(
          id: 'edit-profile',
          init: controller,
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.white)
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "Edit Profile",
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const LabelFormWidget2(
                            labelColor: AppColors.white,
                            label: "Nama User"
                          ),
                          SizedBox(
                            width: 30.w - 34,
                            child: TextFieldWidget(
                              filled: true,
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
                          const LabelFormWidget2(
                            labelColor: AppColors.white,
                            label: "Role"
                          ),
                          SizedBox(
                            width: 30.w - 34,
                            child: DropdownSearchWidget<Role>(
                              enabled: false,
                              filled: true,
                              hintText: "",
                              fillColor: AppColors.white.withOpacity(0.6),
                              validator: Validator.required(),
                              asyncItems: (filter) => controller.getRoles(),
                              onChanged: (Role? newValue){
                                controller.editRoleResult = newValue;
                              },
                              borderRadius: 10,
                              contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
                              selectedItem: controller.editRoleResult,
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
                          const LabelFormWidget2(
                            labelColor: AppColors.white,
                            label: "Email"
                          ),
                          SizedBox(
                            width: 30.w - 34,
                            child: TextFieldWidget(
                              enabled: false,
                              filled: true,
                              name: 'email',
                              hintText: "",
                              fillColor: AppColors.white.withOpacity(0.6),
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
                          const LabelFormWidget2(
                            labelColor: AppColors.white,
                            label: "No Telepon"
                          ),
                          SizedBox(
                            width: 30.w - 34,
                            child: TextFieldWidget(
                              filled: true,
                              name: 'phone_number',
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
                          const LabelFormWidget2(
                            labelColor: AppColors.white,
                            label: "Alamat"
                          ),
                          SizedBox(
                            width: 30.w - 34,
                            child: TextFieldWidget(
                              filled: true,
                              name: 'address',
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
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: PrimaryButtonWidget(
                      width: 12.w,
                      customColors: AppColors.primary,
                      margin: const EdgeInsets.all(0),
                      buttonText: "Edit Profile", 
                      withIcon: true,
                        padding: 12,
                        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600
                        ),
                      onPressed: () async {
                        if(
                          controller.editUserFormKey.currentState != null &&
                          controller.editUserFormKey.currentState!.saveAndValidate()
                        ){
                          controller.editProfile(
                            name: controller.editUserFormKey.currentState!.fields['name']!.value, 
                            phoneNumber: controller.editUserFormKey.currentState!.fields['phone_number']!.value, 
                            address: controller.editUserFormKey.currentState!.fields['address']!.value, 
                            context: context
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}