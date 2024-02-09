import 'package:backoffice_tpt_app/feature/report_financial/report_financial_controller.dart';
import 'package:backoffice_tpt_app/feature/report_financial/widgets/delete_report_financial.dart';
import 'package:backoffice_tpt_app/feature/report_financial/widgets/edit_report_financial.dart';
import 'package:backoffice_tpt_app/model/financial.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinancialReportDataSource extends DataTableSource {
  FinancialReportDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<Financial> data;
  final FinancialReportController controller;
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
            "${DateFormat("dd/MM/yyyy HH:mm").format(item.financialDate!)} WITA",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            controller.getFinancialTypeNamebyTypeId(item.type),
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.information ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            NumberFormat.currency(
              locale: 'id', 
              decimalDigits: 0,
              symbol: "Rp "
            ).format(item.cashIn),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            NumberFormat.currency(
              locale: 'id', 
              decimalDigits: 0,
              symbol: "Rp "
            ).format(item.cashOut),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            NumberFormat.currency(
              locale: 'id', 
              decimalDigits: 0,
              symbol: "Rp "
            ).format(item.balance),
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
                EditFinancialButton(
                  financialId: item.financialId!,
                  userId: item.userId!,
                  controller: controller,
                ),
                const SizedBox(width: 12),
                DeleteFinancialButton(
                  financialId: item.financialId!,
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