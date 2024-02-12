import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/delete_report_purchase.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/view_report_purchase_detail.dart';
import 'package:backoffice_tpt_app/model/purchase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:sizer/sizer.dart';

class PurchaseReportDataSource extends DataTableSource {
  PurchaseReportDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<Purchase> data;
  final PurchaseReportController controller;
  final BuildContext context;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.totalItems.value;

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
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            "${DateFormat("dd/MM/yyyy HH:mm").format(item.purchaseDate!)} WITA",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.supplierName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.totalItem.toString(),
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            NumberFormat.currency(
              locale: 'id', 
              decimalDigits: 0,
              symbol: "Rp "
            ).format(item.totalPrice),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.userName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                ViewPurchaseDetailButton(
                  purchase: item,
                  controller: controller
                ),
                const SizedBox(width: 12),
                PrimaryButtonWidget(
                  width: 5.w,
                  customColors: AppColors.orange,
                  margin: const EdgeInsets.all(0),
                  buttonText: "Edit", 
                  withIcon: true,
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                DeletePurchaseButton(
                  purchaseId: item.purchaseId!,
                  controller: controller
                )
              ],
            ),
          ),
        ),
      ]
    );
  }
}