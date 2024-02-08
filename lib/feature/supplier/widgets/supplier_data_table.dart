import 'package:backoffice_tpt_app/feature/supplier/supplier_controller.dart';
import 'package:backoffice_tpt_app/feature/supplier/widgets/delete_supplier.dart';
import 'package:backoffice_tpt_app/feature/supplier/widgets/edit_supplier.dart';
import 'package:backoffice_tpt_app/model/supplier.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SupplierDataSource extends DataTableSource {
  SupplierDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<Supplier> data;
  final SupplierController controller;
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
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          )
        ),
        DataCell(
          Text(
            item.supplierName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          )
        ),
        DataCell(
          Text(
            item.phoneNumber ?? "-",
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          )
        ),
        DataCell(
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 30.w,
            ),
            child: Text(
              item.address ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ),
        DataCell(
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                EditSupplierButton(
                  supplierId: item.supplierId!,
                  controller: controller,
                ),
                const SizedBox(width: 12),
                DeleteSupplierButton(
                  supplierId: item.supplierId!,
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