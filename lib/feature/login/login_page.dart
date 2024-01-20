import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '/utills/helper/validator.dart';
import '/utills/widget/button/primary_button.dart';
import '/utills/widget/forms/text_field_widget.dart';
import '/resources/resources.dart';

import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        init: LoginController(),
        builder: (controller) {
          return FormBuilder(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 40),
                  Column(
                    children: [
                      Text(
                        "JAMKRIDA\nDIGITAL INFORMATION",
                        style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w700
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Silahkan login untuk melanjutkan",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w300
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFieldWidget(
                      name: 'username',
                      label: 'Username',
                      validator: Validator.required(),
                      keyboardType: TextInputType.text,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      borderRadius: 10,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFieldWidget(
                      name: 'password',
                      label: 'Password',
                      obsecure: controller.isObscure,
                      validator: Validator.required(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      keyboardType: TextInputType.text,
                      borderRadius: 10,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isObscure = !controller.isObscure;
                          controller.update();
                        },
                        icon: controller.isObscure
                          ? const Icon(
                              Icons.visibility_outlined,
                              color: AppColors.blue,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: AppColors.blue,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  PrimaryButtonWidget(
                    buttonText: "LOGIN", 
                    onPressed: () async {
                      if (
                        controller.formKey.currentState != null &&
                        controller.formKey.currentState!.saveAndValidate()
                      ){
                        controller.signInWithEmailAndPassword(
                          controller.formKey.currentState!.fields['username']!.value,
                          controller.formKey.currentState!.fields['password']!.value,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

