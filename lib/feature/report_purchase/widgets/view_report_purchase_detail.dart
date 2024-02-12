import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/report_purchase_detail_table_widget.dart';
import 'package:backoffice_tpt_app/model/purchase.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ViewPurchaseDetailButton extends StatelessWidget {
  const ViewPurchaseDetailButton({
    super.key,
    required this.purchase,
    required this.controller,
  });

  final Purchase purchase;
  final PurchaseReportController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.blue,
      margin: const EdgeInsets.all(0),
      buttonText: "View", 
      withIcon: true,
      icon: const FaIcon(
        FontAwesomeIcons.eye,
        color: AppColors.white,
        size: 16,
      ),  
      onPressed: () async {
        controller.purchaseDetail = purchase;
        await controller.getPurchasesDetail();
        // ignore: use_build_context_synchronously
        PopUpWidget.inputPopUp(
          context: context,
          width: 72.w,
          titleString: "Detail Pembelian", 
          withMiddleText: false,
          content: SizedBox(
            height: 72.h,
            width: 72.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [  
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Total : ${NumberFormat.currency(
                      locale: 'id', 
                      decimalDigits: 0,
                      symbol: "Rp "
                    ).format(purchase.totalPrice)}",
                    textAlign: TextAlign.center, 
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                PurchaseReportDetailTableWidget(
                  controller: controller
                ),
              ],
            ),
          )
        );
      },
    );
  }
}
