import 'package:backoffice_tpt_app/feature/product/product_controller.dart';
import 'package:backoffice_tpt_app/feature/product/widgets/add_product.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/icon_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class ProductHeaderWidget extends StatelessWidget {
  const ProductHeaderWidget({
    super.key,
    required this.controller
  });

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Daftar Produk",
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w700
          ),
        ),
        const Expanded(child: SizedBox()),
        IconButtonWidget(
          controller: controller,
          icon: const FaIcon(
            FontAwesomeIcons.arrowsRotate,
            color: AppColors.white,
            size: 16,
          ),
          onPressed: (){
            controller.refreshPage();
          }, 
        ),
        const SizedBox(width: 16),
        Container(
          color: AppColors.white.withOpacity(0.2),
          width: 2,
          height: 32,
        ),
        const SizedBox(width: 16),
        FormBuilder(
          key: controller.searchformKey,
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
                height: 32,
                child: TextFieldWidget(
                  name: "search", 
                  hintText: "Search",
                  filled: true,
                  keyboardType: TextInputType.text,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, 
                    vertical: 2
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.colorPrimary
                  ),
                ),
              ),
              const SizedBox(width: 16),
              IconButtonWidget(
                controller: controller,
                icon: const Icon(
                  IconlyLight.send,
                  color: AppColors.white,
                  size: 16,
                ),
                onPressed: (){
                  controller.searchKeyword.value = controller.searchformKey.currentState!.fields['search']!.value;
                  controller.getAllProducts(
                    keyword: controller.searchKeyword.value
                  );
                }, 
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Container(
          color: AppColors.white.withOpacity(0.2),
          width: 2,
          height: 32,
        ),
        const SizedBox(width: 16),
        AddProductButton(
          controller: controller
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}