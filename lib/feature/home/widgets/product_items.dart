import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/feature/home/home_controller.dart';
import 'package:backoffice_tpt_app/model/product.dart';
import 'package:backoffice_tpt_app/utills/widget/content/content_list_widget.dart';
import '/resources/resources.dart';
import 'package:sizer/sizer.dart';

class ProductListItem extends StatelessWidget {
  final int index;
  final HomeController controller;
  final Product mData;

  const ProductListItem({
    Key? key, 
    required this.index, 
    required this.controller, 
    required this.mData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {},
      child: Container(
        width: 100.w,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.colorPrimary,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentListWidget(
              title1: "ID Supervisor",
              title2: mData.productName ?? "-"
            ),
            const SizedBox(height: 8),
            ContentListWidget(
              title1: "Nama",
              title2: mData.productCode ?? "-",
            ),
            const SizedBox(height: 8),
            ContentListWidget(
              title1: "No HP",
              title2: mData.categoryName ?? "-",
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}