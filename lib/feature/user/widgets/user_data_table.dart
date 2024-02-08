import 'package:backoffice_tpt_app/feature/user/user_controller.dart';
// import 'package:backoffice_tpt_app/feature/user/widgets/delete_user.dart';
import 'package:backoffice_tpt_app/feature/user/widgets/edit_user.dart';
import 'package:backoffice_tpt_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserDataSource extends DataTableSource {
  UserDataSource({
    required this.data,
    required this.controller,
    required this.context,
  });
  
  final List<UserData> data;
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
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ),
        DataCell(
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 10.w,
            ),
            child: Text(
              item.roleName ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ),
        DataCell(
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 10.w,
            ),
            child: Text(
              item.name ?? "-",
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
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
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 12.w,
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
                EditUserButton(
                  userId: item.userId!,
                  controller: controller,
                ),
                // const SizedBox(width: 12),
                // DeleteUserButton(
                //   userId: item.userId!,
                //   controller: controller
                // )
              ],
            ),
          ),
        ),
      ]
    );
  }
}