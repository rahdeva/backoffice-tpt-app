import 'package:backoffice_tpt_app/feature/user/user_controller.dart';
import 'package:backoffice_tpt_app/model/all_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:sizer/sizer.dart';

class UserDataSource extends DataTableSource {
  UserDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<AllUser> data;
  final UserController controller;
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
            item.roleName ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.name ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.email ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.phoneNumber ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Text(
            item.address ?? "-",
            style: Theme.of(context).textTheme.bodyMedium
          )
        ),
        DataCell(
          Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              children: [
                PrimaryButtonWidget(
                  width: 5.w,
                  customColors: AppColors.orange,
                  margin: const EdgeInsets.all(0),
                  buttonText: "Edit", 
                  withIcon: true,
                  onPressed: () {},
                ),
                const SizedBox(width: 12),
                PrimaryButtonWidget(
                  width: 5.w,
                  customColors: AppColors.red,
                  margin: const EdgeInsets.all(0),
                  buttonText: "Delete", 
                  withIcon: true,
                  icon: const Icon(
                    IconlyLight.delete,
                    color: AppColors.white,
                    size: 16,
                  ), 
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ]
    );
  }
}