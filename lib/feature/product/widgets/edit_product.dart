import 'package:backoffice_tpt_app/feature/product/product_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/currency_text_input_formatter.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/image_picker_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class EditProductButton extends StatelessWidget {
  const EditProductButton({
    super.key,
    required this.productId,
    required this.controller,
  });

  final int productId;
  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.orange,
      margin: const EdgeInsets.all(0),
      buttonText: "Edit", 
      withIcon: true,
      onPressed: () {
        controller.getProductDetail(
          productId : productId,
          isEdit: true 
        );
        PopUpWidget.defaultPopUp(
          context: context,
          width: 60.w,
          titleString: "Edit Produk", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.editProductFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [  
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Kode Produk"
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
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Nama Produk"
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
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Kategori"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'category_id',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.number,
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
                      label: "Merk"
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
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Harga Beli"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'purchase_price',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.number,
                        borderRadius: 10,
                        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400
                        ),
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            locale: 'id',
                            decimalDigits: 0,
                            symbol: 'Rp ',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Harga Jual"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'sale_price',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.number,
                        borderRadius: 10,
                        textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400
                        ),
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            locale: 'id',
                            decimalDigits: 0,
                            symbol: 'Rp ',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Stok"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'stock',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.number,
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
                      label: "Gambar"
                    ),
                    ImagePickerWidget(
                      image: controller.newImage,
                      onTap: (){
                        // controller.showSelectImageOptions(context);
                      }
                    ),
                  ],
                ),
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
                        controller.editProductFormKey.currentState != null &&
                        controller.editProductFormKey.currentState!.saveAndValidate()
                      ){
                        controller.updateProduct(
                          productId: productId,
                          productCode: controller.editProductFormKey.currentState!.fields['product_code']!.value, 
                          productName: controller.editProductFormKey.currentState!.fields['product_name']!.value, 
                          categoryID: controller.editProductFormKey.currentState!.fields['category_id']!.value, 
                          brand: controller.editProductFormKey.currentState!.fields['brand']!.value, 
                          purchasePrice: controller.editProductFormKey.currentState!.fields['purchase_price']!.value, 
                          salePrice: controller.editProductFormKey.currentState!.fields['sale_price']!.value, 
                          stock: controller.editProductFormKey.currentState!.fields['stock']!.value, 
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
