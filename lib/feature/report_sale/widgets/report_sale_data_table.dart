import 'package:backoffice_tpt_app/feature/report_sale/report_sale_controller.dart';
import 'package:backoffice_tpt_app/feature/report_sale/widgets/delete_report_sale.dart';
import 'package:backoffice_tpt_app/feature/report_sale/widgets/view_report_sale_detail.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:backoffice_tpt_app/model/sale.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:sizer/sizer.dart';

class SaleReportDataSource extends DataTableSource {
  SaleReportDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<Sale> data;
  final SaleReportController controller;
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
            "${DateFormat("dd/MM/yyyy HH:mm").format(item.saleDate!)} WITA",
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
                ViewSaleDetailButton(
                  sale: item,
                  controller: controller
                ),
                const SizedBox(width: 12),
                // Later
                PrimaryButtonWidget(
                  width: 5.w,
                  customColors: AppColors.orange,
                  margin: const EdgeInsets.all(0),
                  buttonText: "Edit", 
                  withIcon: true,
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                // Later
                PrimaryButtonWidget(
                  width: 5.w,
                  customColors: AppColors.pink,
                  margin: const EdgeInsets.all(0),
                  buttonText: "Print", 
                  withIcon: true,
                  icon: const FaIcon(
                    FontAwesomeIcons.print,
                    color: AppColors.white,
                    size: 16,
                  ), 
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                DeleteSaleButton(
                  saleId: item.saleId!,
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