import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/add_purchase_controller.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:flutter/material.dart';

class PurchasingTableWidget extends StatelessWidget {
  const PurchasingTableWidget({
    super.key,
    required this.controller
  });

  final AddPurchaseReportController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.only(right: 0),
      width: double.infinity,
      child: Theme(
        data: ThemeData(
          cardTheme: Theme.of(context).cardTheme,
          textTheme: Theme.of(context).textTheme.copyWith(
            bodySmall: Theme.of(context).textTheme.titleSmall,
          )
        ),
        child: DataTable(
          key: controller.purchasingKey,
          columnSpacing : 0,
          headingRowHeight: 46,
          headingRowColor: MaterialStateProperty.resolveWith(
            (states) => AppColors.primary
          ),
          dataRowColor: MaterialStateColor.resolveWith(
            (states) => Colors.white
          ),
          rows: controller.purchasingDataList,
          columns: [
            dataColumnWidget(
              context, labelText: "No"
            ),
            dataColumnWidget(
              context, labelText: "Kode Produk"
            ),
            dataColumnWidget(
              context, labelText: "Kategori"
            ),
            dataColumnWidget(
              context, labelText: "Nama Produk"
            ),
            dataColumnWidget(
              context, labelText: "Harga Beli"
            ),
            dataColumnWidget(
              context, labelText: "Jumlah"
            ),
            dataColumnWidget(
              context, labelText: "SubTotal"
            ),
            dataColumnWidget(
              context, labelText: "Aksi"
            ),
          ],
        ),
      ),
    );
  }
}
