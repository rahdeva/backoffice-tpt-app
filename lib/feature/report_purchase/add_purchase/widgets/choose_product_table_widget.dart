import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/add_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/add_purchase/widgets/choose_product_data_table.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:flutter/material.dart';

class ChooseProductTableWidget extends StatelessWidget {
  const ChooseProductTableWidget({
    super.key,
    required this.controller
  });

  final AddPurchaseReportController controller;

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
                    key: controller.tableProductKey,
                    columnSpacing : 0,
                    rowsPerPage: controller.productPageSize.value,
                    availableRowsPerPage: const [8, 10, 15],
                    headingRowHeight: 46,
                    onRowsPerPageChanged: (value) {
                      controller.onProductRowsPerPageChanged(value!);
                    },
                    onPageChanged: (value) {
                      controller.onProductPageChanged(value);
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
                        context, labelText: "Kategori"
                      ),
                      dataColumnWidget(
                        context, labelText: "Nama Produk"
                      ),
                      dataColumnWidget(
                        context, labelText: "Merk"
                      ),
                      dataColumnWidget(
                        context, labelText: "Harga Beli"
                      ),
                      dataColumnWidget(
                        context, labelText: "Harga Jual"
                      ),
                      dataColumnWidget(
                        context, labelText: "Stok"
                      ),
                      dataColumnWidget(
                        context, labelText: "Aksi"
                      ),
                    ],
                    source: ChooseProductDataSource(
                      data: controller.productDataList,
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
