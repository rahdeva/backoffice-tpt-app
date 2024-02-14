import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/add_purchase_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupplierChoosenDetail extends StatelessWidget {
  const SupplierChoosenDetail({
    super.key, 
    required this.controller,
  });

  final AddPurchaseReportController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10.w,
                child: Text(
                  "Supplier",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Text(
                ":   ${controller.supplierChoosen?.supplierName ?? "-"}",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 10.w,
                child: Text(
                  "No Telepon",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Text(
                ":   ${controller.supplierChoosen?.phoneNumber ?? "-"}",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SizedBox(
                width: 10.w,
                child: Text(
                  "Alamat",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  ":   ${controller.supplierChoosen?.address ?? "-"}",
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
