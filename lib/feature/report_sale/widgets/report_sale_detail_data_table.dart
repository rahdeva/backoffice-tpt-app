import 'package:backoffice_tpt_app/feature/report_sale/report_sale_controller.dart';
import 'package:backoffice_tpt_app/model/sale_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SaleReportDetailDataSource extends DataTableSource {
  SaleReportDetailDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<SaleDetail> data;
  final SaleReportController controller;
  final BuildContext context;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => controller.detailTotalItems.value;

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
            item.productCode ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.productName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            NumberFormat.currency(
              locale: 'id', 
              decimalDigits: 0,
              symbol: "Rp "
            ).format(item.salePrice),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.quantity.toString(),
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            NumberFormat.currency(
              locale: 'id', 
              decimalDigits: 0,
              symbol: "Rp "
            ).format(item.subtotal),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        // DataCell(
        //   Container(
        //     margin: const EdgeInsets.all(8),
        //     child: Row(
        //       children: [
        //         PrimaryButtonWidget(
        //           width: 5.w,
        //           customColors: AppColors.orange,
        //           margin: const EdgeInsets.all(0),
        //           buttonText: "Edit", 
        //           withIcon: true,
        //           onPressed: () {},
        //         ),
        //         const SizedBox(width: 12),
        //         PrimaryButtonWidget(
        //           width: 5.w,
        //           customColors: AppColors.red,
        //           margin: const EdgeInsets.all(0),
        //           buttonText: "Delete", 
        //           withIcon: true,
        //           icon: const Icon(
        //             IconlyLight.delete,
        //             color: AppColors.white,
        //             size: 16,
        //           ), 
        //           onPressed: () {},
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ]
    );
  }
}