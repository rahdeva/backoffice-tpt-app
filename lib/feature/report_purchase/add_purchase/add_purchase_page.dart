import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/add_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/widgets/choose_product_table_widget.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/widgets/purchasing_table_widget.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/widgets/supplier_choosen_detail.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/icon_button.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/datetime_picker_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddPurchaseReportPage extends StatelessWidget {
  const AddPurchaseReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPurchaseReportController>(
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            body: FormBuilder(
              key: controller.addPurchaseFormKey,
              child: Container(
                margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                decoration: BoxDecoration(
                  color: AppColors.background2,
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(right: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back, 
                                  color: AppColors.backgroundWhite
                                ),
                                onPressed: () {
                                  Get.back();
                                  Get.back();
                                }
                              ), 
                              const SizedBox(width: 16),
                              Text(
                                "Tambah Laporan Pembelian",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const LabelFormWidget2(
                                label: "Tanggal Pembelian",
                                labelColor: AppColors.white
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: 20.w,
                                child: DateTimePickerWidget(
                                  name: 'purchase_date',
                                  filled: true,
                                  inputType: InputType.both,
                                  validator: Validator.required(),
                                  lastDate: DateTime.now(),
                                  hintText: "",
                                  borderRadius: 10,
                                  contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
                                  textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              SizedBox(
                                width: 6.w,
                                child: ElevatedButton(
                                  onPressed: (){
                                    controller.addPurchaseFormKey.currentState!.patchValue({
                                      "purchase_date": DateTime.now()
                                    });
                                  }, 
                                  style:  ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.white,
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: AppColors.primary,
                                      )
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Now",
                                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                        color: AppColors.background1,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  )
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          SupplierChoosenDetail(controller: controller),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 100.w,
                            child: PrimaryButtonWidget(
                              customColors: AppColors.primary,
                              margin: const EdgeInsets.all(0),
                              padding: 12,
                              buttonText: "Pilih Produk", 
                              withIcon: true,
                              icon: const FaIcon(
                                FontAwesomeIcons.squareCheck,
                                color: AppColors.white,
                                size: 16,
                              ),
                              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600
                              ),
                              onPressed: () async {
                                await controller.getAllProducts();
                                // ignore: use_build_context_synchronously
                                PopUpWidget.inputPopUp(
                                  context: context,
                                  width: 72.w,
                                  titleString: "Pilih Produk", 
                                  withMiddleText: false,
                                  content: SizedBox(
                                    height: 80.h,
                                    width: 72.w,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children : [
                                        const SizedBox(height: 16),  
                                        FormBuilder(
                                          key: controller.searchProductformKey,
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
                                                  controller.searchProductKeyword.value = controller.searchProductformKey.currentState!.fields['search']!.value;
                                                  controller.getAllProducts(
                                                    keyword: controller.searchProductKeyword.value
                                                  );
                                                }, 
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        GetBuilder(
                                          id: "product-table",
                                          init: controller,
                                          builder: (_) {
                                            return ChooseProductTableWidget(
                                              controller: controller
                                            );
                                          }
                                        ),
                                      ],
                                    ),
                                  )
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                          GetBuilder(
                            id: "purchase-table",
                            init: controller,
                            builder: (_) {
                              return PurchasingTableWidget(
                                controller: controller
                              );
                            }
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8)
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Total   ",
                                          textAlign: TextAlign.left,
                                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                            fontSize: 24,
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            ":   ${NumberFormat.currency(
                                              locale: 'id', 
                                              decimalDigits: 0,
                                              symbol: "Rp "
                                            ).format(controller.total.value)}",
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                                              fontSize: 24,
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 24),
                              PrimaryButtonWidget(
                                customColors: AppColors.green,
                                margin: const EdgeInsets.all(0),
                                padding: 12,
                                buttonText: "Save", 
                                withIcon: true,
                                icon: const FaIcon(
                                  FontAwesomeIcons.floppyDisk,
                                  color: AppColors.white,
                                  size: 16,
                                ), 
                                textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w600
                                ),
                                onPressed: () {
                                  if(
                                    controller.addPurchaseFormKey.currentState != null &&
                                    controller.addPurchaseFormKey.currentState!.saveAndValidate() &&
                                    controller.purchasingDataList.isNotEmpty
                                  ){
                                    controller.addNewPurchase(
                                      purchaseDate: controller.addPurchaseFormKey.currentState!.fields['purchase_date']!.value,
                                      context: context
                                    );
                                  }
                                }
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}