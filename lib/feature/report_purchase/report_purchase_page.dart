import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_controller.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/widgets/report_purchase_data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/responsive.dart';
import 'package:backoffice_tpt_app/utills/widget/table/data_column_widget.dart';
import 'package:sizer/sizer.dart';

class PurchaseReportPage extends StatelessWidget {
  const PurchaseReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseReportController>(
      builder: (controller) {
        return SafeArea(
          child: Container(
            width: 100.w,
            height: 100.h,
            margin: const EdgeInsets.fromLTRB(24, 24, 0, 0),
            decoration: const BoxDecoration(
              color: AppColors.background2,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!Responsive.isDesktop(context))
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      }
                    ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                        height: 100.h-24,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Laporan Pembelian",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700
                              ),
                            ),
                            const SizedBox(height: 24),
                            // SizedBox(
                            //   width: 20.w,
                            //   child: TextFieldWidget(
                            //     name: "Search", 
                            //     hintText: "Search",
                            //     filled: true,
                            //     keyboardType: TextInputType.text,
                            //     contentPadding: const EdgeInsets.symmetric(
                            //       horizontal: 12, 
                            //       vertical: 12
                            //     ),
                            //     prefixIcon: const Icon(
                            //       Icons.search,
                            //     ),
                            //     hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            //       color: AppColors.colorPrimary
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 24),
                            Expanded(
                              // height: 70.h,
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
                                              bodySmall: Theme.of(context).textTheme.titleSmall
                                            )
                                          ),
                                          child: PaginatedDataTable(
                                            key: controller.tableKey,
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
