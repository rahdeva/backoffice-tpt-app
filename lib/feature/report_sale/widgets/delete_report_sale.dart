import 'package:backoffice_tpt_app/feature/report_sale/report_sale_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/pop_up/pop_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class DeleteSaleButton extends StatelessWidget {
  const DeleteSaleButton({
    super.key,
    required this.saleId,
    required this.controller,
  });

  final int saleId;
  final SaleReportController controller;

  @override
  Widget build(BuildContext context) {
    return PrimaryButtonWidget(
      customColors: AppColors.red,
      margin: const EdgeInsets.all(0),
      buttonText: "Delete", 
      withIcon: true,
      icon: const Icon(
        IconlyLight.delete,
        color: AppColors.white,
        size: 16,
      ), 
      onPressed: () {
        PopUpWidget.confirmationPopUp(
          context: context, 
          titleString: "Are you sure to delete?", 
          popUpConfirmText: "Delete", 
          popUpCancelText: "Cancel",  
          confirmOnPress: (){
            controller.deleteSaleReport(
              saleId: saleId,
              context: context
            );
          }, 
      );
      },
    );
  }
}
