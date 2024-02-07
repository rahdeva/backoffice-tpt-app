import 'package:backoffice_tpt_app/feature/category/category_controller.dart';
import 'package:backoffice_tpt_app/feature/category/widgets/delete_category.dart';
import 'package:backoffice_tpt_app/feature/category/widgets/edit_category.dart';
import 'package:backoffice_tpt_app/model/category.dart';
import 'package:flutter/material.dart';

class CategoryDataSource extends DataTableSource {
  CategoryDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<Category> data;
  final CategoryController controller;
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
            item.categoryCode ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.categoryName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.categoryColor ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                EditCategoryButton(
                  categoryId: item.categoryId!,
                  controller: controller,
                ),
                const SizedBox(width: 12),
                DeleteCategoryButton(
                  categoryId: item.categoryId!,
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