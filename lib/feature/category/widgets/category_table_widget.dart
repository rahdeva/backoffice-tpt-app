import 'package:backoffice_tpt_app/feature/category/category_controller.dart';
import 'package:backoffice_tpt_app/feature/category/widgets/category_data_table.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:flutter/material.dart';

class CategoryTableWidget extends StatelessWidget {
  const CategoryTableWidget({
    super.key,
    required this.controller
  });

  final CategoryController controller;

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
                    textTheme: TextTheme(
                      displayLarge: Theme.of(context).textTheme.displayLarge,
                      displayMedium: Theme.of(context).textTheme.displayMedium,
                      displaySmall: Theme.of(context).textTheme.displaySmall,
                      headlineLarge: Theme.of(context).textTheme.headlineLarge,
                      headlineMedium: Theme.of(context).textTheme.headlineMedium,
                      headlineSmall: Theme.of(context).textTheme.headlineSmall,
                      bodyLarge: Theme.of(context).textTheme.bodyLarge,
                      bodyMedium: Theme.of(context).textTheme.bodyMedium,
                      bodySmall: Theme.of(context).textTheme.titleSmall,
                    )
                  ),
                  child: PaginatedDataTable(
                    key: controller.tableKey,
                    columnSpacing : 0,
                    rowsPerPage: controller.pageSize.value,
                    availableRowsPerPage: const [5, 10, 25],
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
                        context, labelText: "Kode Kategori"
                      ),
                      dataColumnWidget(
                        context, labelText: "Nama Kategori"
                      ),
                      dataColumnWidget(
                        context, labelText: "Warna Kategori"
                      ),
                      dataColumnWidget(
                        context, labelText: "Aksi"
                      ),
                    ],
                    source: CategoryDataSource(
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
