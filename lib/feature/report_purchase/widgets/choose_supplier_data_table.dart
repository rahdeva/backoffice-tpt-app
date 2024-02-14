import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/model/supplier.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/routes/page_names.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ChooseSupplierDataSource extends DataTableSource {
  ChooseSupplierDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<Supplier> data;
  final PurchaseReportController controller;
  final BuildContext context;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.chooseSupplierTotalItems.value;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow? getRow(int index) {
    if (index >= data.length) {
      return null;
    }

    final item = data[index];

    return DataRow(
      cells: [
        DataCell(
          Text(
            (index + 1).toString(),
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          )
        ),
        DataCell(
          Text(
            item.supplierName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          )
        ),
        DataCell(
          Text(
            item.phoneNumber ?? "-",
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          )
        ),
        DataCell(
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 30.w,
            ),
            child: Text(
              item.address ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ),
        DataCell(
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                PrimaryButtonWidget(
                  width: 5.w,
                  customColors: AppColors.primary,
                  margin: const EdgeInsets.all(0),
                  buttonText: "Pilih", 
                  withIcon: true,
                  icon: const FaIcon(
                    FontAwesomeIcons.squareCheck,
                    color: AppColors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    Get.toNamed(
                      PageName.ADD_REPORT_PURCHASE,
                      arguments: item
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }
}