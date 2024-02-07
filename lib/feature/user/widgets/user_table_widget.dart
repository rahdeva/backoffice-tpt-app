import 'package:backoffice_tpt_app/feature/user/user_controller.dart';
import 'package:backoffice_tpt_app/feature/user/widgets/user_data_table.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:flutter/material.dart';

class UserTableWidget extends StatelessWidget {
  const UserTableWidget({
    super.key,
    required this.controller
  });

  final UserController controller;

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
                        context, labelText: "Role"
                      ),
                      dataColumnWidget(
                        context, labelText: "Nama User"
                      ),
                      dataColumnWidget(
                        context, labelText: "Email"
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
                    source: UserDataSource(
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
