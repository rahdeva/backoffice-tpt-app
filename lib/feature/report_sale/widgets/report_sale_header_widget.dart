import 'package:backoffice_tpt_app/feature/report_sale/report_sale_controller.dart';
import 'package:backoffice_tpt_app/feature/report_sale/widgets/add_report_sale.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SaleReportHeaderWidget extends StatelessWidget {
  const SaleReportHeaderWidget({
    super.key,
    required this.controller
  });

  final SaleReportController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Laporan Penjualan",
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
        // const SizedBox(width: 16),
        // Container(
        //   color: AppColors.white.withOpacity(0.2),
        //   width: 2,
        //   height: 32,
        // ),
        // const SizedBox(width: 16),
        // FormBuilder(
        //   key: controller.searchformKey,
        //   child: Row(
        //     children: [
        //       SizedBox(
        //         width: 20.w,
        //         height: 32,
        //         child: TextFieldWidget(
        //           name: "search", 
        //           hintText: "Search",
        //           filled: true,
        //           keyboardType: TextInputType.text,
        //           contentPadding: const EdgeInsets.symmetric(
        //             horizontal: 12, 
        //             vertical: 2
        //           ),
        //           prefixIcon: const Icon(
        //             Icons.search,
        //           ),
        //           hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
        //             color: AppColors.colorPrimary
        //           ),
        //         ),
        //       ),
        //       const SizedBox(width: 16),
        //       IconButtonWidget(
        //         controller: controller,
        //         icon: const Icon(
        //           IconlyLight.send,
        //           color: AppColors.white,
        //           size: 16,
        //         ),
        //         onPressed: (){
        //           controller.searchKeyword.value = controller.searchformKey.currentState!.fields['search']!.value;
        //           controller.getFinancialReports(
        //             keyword: controller.searchKeyword.value
        //           );
        //         }, 
        //       ),
        //     ],
        //   ),
        // ),
        // const SizedBox(width: 16),
        // Container(
        //   color: AppColors.white.withOpacity(0.2),
        //   width: 2,
        //   height: 32,
        // ),
        const SizedBox(width: 16),
        Container(
          color: AppColors.white.withOpacity(0.2),
          width: 2,
          height: 32,
        ),
        const SizedBox(width: 16),
        AddSaleButton(
          controller: controller
        ),
        const SizedBox(width: 24),
      ],
    );
  }
}