import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/choose_supplier_data_table.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:flutter/material.dart';

class ChooseSupplierTableWidget extends StatelessWidget {
  const ChooseSupplierTableWidget({
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
              controller: controller.scrollController3,
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
                    key: controller.tableSupplierKey,
                    columnSpacing : 0,
                    rowsPerPage: controller.chooseSupplierPageSize.value,
                    availableRowsPerPage: const [8, 10, 15],
                    headingRowHeight: 46,
                    onRowsPerPageChanged: (value) {
                      controller.onSupplierRowsPerPageChanged(value!);
                    },
                    onPageChanged: (value) {
                      controller.onSupplierPageChanged(value);
                    },
                    headingRowColor: MaterialStateProperty.resolveWith(
                      (states) => AppColors.primary
                    ),
                    columns: [
                      dataColumnWidget(
                        context, labelText: "No"
                      ),
                      dataColumnWidget(
                        context, labelText: "Nama Supplier"
                      ),
                      dataColumnWidget(
                        context, labelText: "No Telepon"
                      ),
                      dataColumnWidget(
                        context, labelText: "Alamat"
                      ),
                      dataColumnWidget(
                        context, labelText: "Aksi"
                      ),
                    ],
                    source: ChooseSupplierDataSource(
                      data: controller.supplierDataList,
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
