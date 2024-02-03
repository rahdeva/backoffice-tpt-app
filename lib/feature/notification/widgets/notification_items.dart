import 'package:backoffice_tpt_app/model/product.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:backoffice_tpt_app/feature/notification/notification_controller.dart';
import '/resources/resources.dart';
import 'package:sizer/sizer.dart';

class NotificationListItem extends StatelessWidget {
  final int index;
  final NotificationController controller;
  final Product mData;

  const NotificationListItem({
    Key? key, 
    required this.index, 
    required this.controller, 
    required this.mData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 100.w,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.10),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            )
          ]
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mData.productId != null
                ? mData.productId.toString()
                : "-",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 8),
              Text(
                mData.productCode != null && mData.productCode != ""
                ? mData.productCode!
                : "-",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400
                ),
              ),
              const SizedBox(height: 8),
              Text(
                mData.productName != null && mData.productName != ""
                ? mData.productName!
                : "-",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
