import 'package:backoffice_tpt_app/feature/report_financial/report_financial_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/currency_text_input_formatter.dart';
import 'package:backoffice_tpt_app/utills/helper/validator.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/label_form_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class EditFinancialButton extends StatelessWidget {
  const EditFinancialButton({
    super.key,
    required this.financialId,
    required this.controller,
  });

  final int financialId;
  final FinancialReportController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.orange,
      margin: const EdgeInsets.all(0),
      buttonText: "Edit", 
      withIcon: true,
      onPressed: () {
        controller.getFinancialReportDetail(
          financialId : financialId,
          isEdit: true 
        );
        PopUpWidget.defaultPopUp(
          context: context,
          width: 60.w,
          titleString: "Edit Laporan", 
          withMiddleText: false,
          content: FormBuilder(
            key: controller.editFinancialReportFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [  
                const SizedBox(height: 24),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    const LabelFormWidget2(
                      label: "Tanggal"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'financial_date',
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
                      label: "Jenis"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'type',
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
                      label: "Keterangan"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'information',
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
                      label: "Uang Masuk"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'cash_in',
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
                      label: "Uang Keluar"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'cash_out',
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
                      label: "Saldo"
                    ),
                    SizedBox(
                      width: 50.w - 16,
                      height: 32,
                      child: TextFieldWidget(
                        name: 'balance',
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
                        controller.editFinancialReportFormKey.currentState != null &&
                        controller.editFinancialReportFormKey.currentState!.saveAndValidate()
                      ){
                        controller.updateFinancialReport(
                          financialId: financialId,
                          financialDate: controller.addFinancialReportFormKey.currentState!.fields['financial_date']!.value,
                          type: controller.addFinancialReportFormKey.currentState!.fields['type']!.value,
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