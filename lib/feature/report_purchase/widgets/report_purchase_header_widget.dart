import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/add_report_purchase.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PurchaseReportHeaderWidget extends StatelessWidget {
  const PurchaseReportHeaderWidget({
    super.key,
    required this.controller
  });

  final PurchaseReportController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Laporan Pembelian",
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
        AddPurchaseButton(
          controller: controller
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}