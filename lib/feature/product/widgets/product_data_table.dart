import 'package:backoffice_tpt_app/feature/product/product_controller.dart';
import 'package:backoffice_tpt_app/feature/product/widgets/delete_product.dart';
import 'package:backoffice_tpt_app/feature/product/widgets/edit_product.dart';
import 'package:backoffice_tpt_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDataSource extends DataTableSource {
  ProductDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<Product> data;
  final ProductController controller;
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
            item.productCode ?? "-",
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
            item.productName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.brand == null || item.brand == ""
            ? "-"
            : item.brand!,
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            NumberFormat.currency(
              locale: 'id', 
              decimalDigits: 0,
              symbol: "Rp "
            ).format(item.purchasePrice),
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
            ).format(item.salePrice),
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.stock == null
            ? "-"
            : item.stock.toString(),
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.sold == null
            ? "-"
            : item.sold.toString(),
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                EditProductButton(
                  productId: item.productId!,
                  controller: controller,
                ),
                const SizedBox(width: 12),
                DeleteProductButton(
                  productId: item.productId!,
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