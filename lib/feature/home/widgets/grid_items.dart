// ignore_for_file: must_be_immutable
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class GridItems extends StatelessWidget {
  GridItems({
    Key? key,
    required this.index,
    required this.icon,
    required this.title,
    required this.total,
    required this.isPrice,
  }) : super(key: key);

  int index;
  Widget? icon;
  String? title;
  int? total;
  bool? isPrice;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientList(index),
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              boxShadow: [ AppElevation.elevation4px ]
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: AppImages.imgHomePolygon.image(
              width: 8.w
            ),
          ),
          icon == null 
          ? const SizedBox()
          : Container(
            margin: EdgeInsets.only(right: 16, top: index == 2 ? 24 : 16),
            child: Align(
                alignment: Alignment.topRight,
                  child: icon,
                ),
            ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.only(left: 16, bottom: 16),
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    isPrice == true
                    ? NumberFormat.currency(
                        locale: 'id', 
                        decimalDigits: 0,
                        symbol: "Rp "
                      ).format(total)
                    :  total.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 36,
                      color: AppColors.white,
                      fontWeight: FontWeight.w700
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ),
                FittedBox(
                  child: Text(
                    title ?? "-",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 24,
                      color: AppColors.white,
                      fontWeight: FontWeight.w400
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Color> gradientList(int index){
    switch(index){
      case 0:
        return [
          AppColors.greenGradient1,
          AppColors.greenGradient2,
        ];
      case 1:
        return [
          AppColors.blueGradient1,
          AppColors.blueGradient2,
        ];
      case 2:
        return [
          AppColors.cyanGradient1,
          AppColors.cyanGradient2,
        ];
      case 3:
        return [
          AppColors.redGradient1,
          AppColors.redGradient2,
        ];
      case 4:
        return [
          AppColors.chocoGradient1,
          AppColors.chocoGradient2,
        ];
      case 5:
        return [
          AppColors.purpleGradient1,
          AppColors.purpleGradient2,
        ];
      default:
        return [
          AppColors.greenGradient1,
          AppColors.greenGradient2,
        ];
    }
  }

  // void get
}
