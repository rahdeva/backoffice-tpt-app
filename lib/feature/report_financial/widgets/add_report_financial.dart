import 'package:backoffice_tpt_app/feature/report_financial/report_financial_controller.dart';
import 'package:backoffice_tpt_app/model/financial_type.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/currency_text_input_formatter.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/datetime_picker_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/dropdown_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:sizer/sizer.dart';

class AddFinancialButton extends StatelessWidget {
  const AddFinancialButton({
    super.key,
    required this.controller,
  });

  final FinancialReportController controller;

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
      onPressed: () {
        PopUpWidget.inputPopUp(
          context: context,
          width: 60.w,
          titleString: "Tambah Laporan Keuangan", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.addFinancialReportFormKey,
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
                      label: "Tanggal"
                    ),
                    Expanded(
                      child: DateTimePickerWidget(
                        name: 'financial_date',
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
                          controller.addFinancialReportFormKey.currentState!.patchValue({
                            "financial_date": DateTime.now()
                          });
                        }, 
                        style:  ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
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
                              color: AppColors.black,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                        )
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Jenis"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: DropdownWidget<FinancialType>(
                        hintText: "",
                        validator: Validator.required(),
                        items: controller.financialTypeList,
                        onChanged: (FinancialType? newValue){
                          controller.addfinancialTypeResult = newValue;
                        },
                        borderRadius: 10,
                        selectedItem: controller.addfinancialTypeResult,
                        contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
                        itemAsString: (FinancialType type) => type.typeName ?? "-",
                        itemBuilder: (context, item, isSelected) {
                          return ListTile(
                            title: Text(
                              item.typeName ?? "-",
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
                      label: "Keterangan"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'information',
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
                      label: "Uang Masuk"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'cash_in',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.number,
                        borderRadius: 10,
                        contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Uang Keluar"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'cash_out',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.number,
                        borderRadius: 10,
                        contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Saldo"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      child: TextFieldWidget(
                        name: 'balance',
                        hintText: "",
                        validator: Validator.required(),
                        keyboardType: TextInputType.number,
                        borderRadius: 10,
                        contentPadding: const EdgeInsets.fromLTRB(12,12,12,12),
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
                const SizedBox(height: 24),
                Container(
                  margin: const EdgeInsets.only(right: 0),
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
                        controller.addFinancialReportFormKey.currentState != null &&
                        controller.addFinancialReportFormKey.currentState!.saveAndValidate() && 
                        controller.addfinancialTypeResult != null
                      ){
                        controller.addNewFinancialReport(
                          financialDate: controller.addFinancialReportFormKey.currentState!.fields['financial_date']!.value,
                          type: controller.addfinancialTypeResult!.typeId!,
                          information: controller.addFinancialReportFormKey.currentState!.fields['information']!.value,
                          cashIn: controller.addFinancialReportFormKey.currentState!.fields['cash_in']!.value,
                          cashOut: controller.addFinancialReportFormKey.currentState!.fields['cash_out']!.value,
                          balance: controller.addFinancialReportFormKey.currentState!.fields['balance']!.value,
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
