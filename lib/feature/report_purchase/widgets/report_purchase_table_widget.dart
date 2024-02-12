import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/report_purchase_data_table.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:flutter/material.dart';

class PurchaseReportTableWidget extends StatelessWidget {
  const PurchaseReportTableWidget({
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
            thumbVisibility: true,
            child: SingleChildScrollView(
              controller: controller.scrollController,
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.only(right: 24),
                width: double.infinity,
                child: Theme(
                  data: ThemeData(
                    cardTheme: Theme.of(context).cardTheme,
                    textTheme: Theme.of(context).textTheme.copyWith(
                      bodySmall: Theme.of(context).textTheme.titleSmall,
                    )
                  ),
                  child: PaginatedDataTable(
                    key: controller.tableKey,
                    columnSpacing : 0,
                    rowsPerPage: controller.pageSize.value,
                    availableRowsPerPage: const [10, 25, 50],
                    headingRowHeight: 46,
                    onRowsPerPageChanged: (value) {
                      controller.onRowsPerPageChanged(value!);
                    },
                    onPageChanged: (value) {
                      controller.onPageChanged(value);
                    },
                    headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.primary
                    ),
                    columns: [
                      dataColumnWidget(
                        context, labelText: "No"
                      ),
                      dataColumnWidget(
                        context, labelText: "Tanggal"
                      ),
                      dataColumnWidget(
                        context, labelText: "Supplier"
                      ),
                      dataColumnWidget(
                        context, labelText: "Total Item"
                      ),
                      dataColumnWidget(
                        context, labelText: "Total Price"
                      ),
                      dataColumnWidget(
                        context, labelText: "User"
                      ),
                      dataColumnWidget(
                        context, labelText: "Aksi"
                      ),
                    ],
                    source: PurchaseReportDataSource(
                      data: controller.dataList,
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
