import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/report_purchase_detail_data_table.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:flutter/material.dart';

class PurchaseReportDetailTableWidget extends StatelessWidget {
  const PurchaseReportDetailTableWidget({
    super.key,
    required this.controller
  });

  final PurchaseReportController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (controller.isLoading)
        ? const Center(child: CircularProgressIndicator())
        : Scrollbar(
            thumbVisibility: false,
            child: SingleChildScrollView(
              controller: controller.scrollController2,
              child: Container(
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
                  child: PaginatedDataTable(
                    key: controller.tableDetailKey,
                    columnSpacing : 0,
                    rowsPerPage: controller.detailPageSize.value,
                    availableRowsPerPage: const [8, 10, 15],
                    headingRowHeight: 46,
                    onRowsPerPageChanged: (value) {
                      controller.onDetailRowsPerPageChanged(value!);
                    },
                    onPageChanged: (value) {
                      controller.onDetailPageChanged(value);
                    },
                    headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.primary
                    ),
                    columns: [
                      dataColumnWidget(
                        context, labelText: "No"
                      ),
                      dataColumnWidget(
                        context, labelText: "Kode Produk"
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
                      // dataColumnWidget(
                      //   context, labelText: "Aksi"
                      // ),
                    ],
                    source: PurchaseReportDetailDataSource(
                      data: controller.detailDataList,
                      controller: controller,
                      context: context
                    ),
                  ),
                ),
              ),
            ),
        ),
    );
  }
}
