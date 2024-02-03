import 'package:backoffice_tpt_app/feature/product/product_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
        SizedBox(
          width: 20.w,
          height: 32,
          child: TextFieldWidget(
            name: "Search", 
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
        PrimaryButtonWidget(
          customColors: AppColors.yellow,
          margin: const EdgeInsets.all(0),
          buttonText: "Tambah Produk", 
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
              titleString: "Tambah Produk", 
              withMiddleText: false,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children : [  
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Kode Produk",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'product_code',
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
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Nama Produk",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'product_name',
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
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Kategori",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'category_id',
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
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Merk",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'brand',
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
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Harga Beli",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'purchase_price',
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
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Harga Jual",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'sale_price',
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
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Stok",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'stock',
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
                      SizedBox(
                        width: 10.w - 16,
                        child: Text(
                          "Gambar",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50.w - 16,
                        height: 32,
                        child: TextFieldWidget(
                          name: 'image',
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
                  Align(
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
                      onPressed: () {}
                    ),
                  )
                ],
              )
            );
          },
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}
