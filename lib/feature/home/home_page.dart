import 'package:backoffice_tpt_app/feature/home/widgets/grid_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/responsive.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '/feature/home/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!Responsive.isDesktop(context))
                    IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      }
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Toko Perlengkapan Ternak",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppColors.grey,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          margin: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                          child: GridView.builder(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1 / 1.5,
                              crossAxisSpacing: 40, // Spacing between items horizontally
                              mainAxisSpacing: 40, // Spacing between items vertically
                              mainAxisExtent: 240,
                            ),
                            clipBehavior: Clip.hardEdge,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.gridHomeData.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return GridItems(
                                index: index,
                                icon: controller.gridHomeData[index].icon!,
                                title: controller.gridHomeData[index].title!,
                                total: controller.gridHomeData[index].total!,
                                isPrice: controller.gridHomeData[index].isPrice!,
                              );
                            }
                          ),
                        ),
                      ],
                    ),
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