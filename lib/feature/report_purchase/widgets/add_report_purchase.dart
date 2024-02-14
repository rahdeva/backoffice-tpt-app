import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/choose_supplier_table_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/button/icon_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
class AddPurchaseButton extends StatelessWidget {
  const AddPurchaseButton({
    super.key,
    required this.controller,
  });

  final PurchaseReportController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.yellow,
      margin: const EdgeInsets.all(0),
      buttonText: "Tambah Laporan", 
      withIcon: true,
      icon: const Icon(
        IconlyLight.plus,
        color: AppColors.white,
        size: 16,
      ), 
      onPressed: () async {
        await controller.getAllSuppliers();
        // ignore: use_build_context_synchronously
        PopUpWidget.inputPopUp(
          context: context,
          width: 72.w,
          titleString: "Pilih Supplier", 
          withMiddleText: false,
          content: SizedBox(
            height: 76.h,
            width: 72.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                const SizedBox(height: 16),  
                FormBuilder(
                  key: controller.searchSupplierformKey,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                        height: 32,
                        child: const TextFieldWidget(
                          name: "search", 
                          hintText: "Search",
                          filled: true,
                          keyboardType: TextInputType.text,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12, 
                            vertical: 2
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                          hintStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
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
                          controller.searchSupplierKeyword.value = controller.searchSupplierformKey.currentState!.fields['search']!.value;
                          controller.getAllSuppliers(
                            keyword: controller.searchSupplierKeyword.value
                          );
                        }, 
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GetBuilder(
                  id: "supplier-table",
                  init: controller,
                  builder: (_) {
                    return ChooseSupplierTableWidget(
                      controller: controller
                    );
                  }
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
