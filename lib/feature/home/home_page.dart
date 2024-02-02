import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/home/widgets/product_list_builder.dart';
import 'package:backoffice_tpt_app/resources/resources.dart';
import 'package:backoffice_tpt_app/utills/helper/responsive.dart';
import 'package:backoffice_tpt_app/utills/widget/button/primary_button.dart';
import 'package:backoffice_tpt_app/utills/widget/forms/text_field_widget.dart';
import 'package:backoffice_tpt_app/utills/widget/state/empty_state_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
            margin: const EdgeInsets.fromLTRB(24, 40, 0, 0),
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
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                              height: 100.h-40,
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
                                    "Tuesday, 09 January 2024",
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: AppColors.grey,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  SizedBox(
                                    width: 20.w,
                                    child: TextFieldWidget(
                                      name: "Search", 
                                      hintText: "Search",
                                      filled: true,
                                      keyboardType: TextInputType.text,
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, 
                                        vertical: 12
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.search,
                                      ),
                                      hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                        color: AppColors.colorPrimary
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        SmartRefresher(
                                          enablePullDown: true,
                                          enablePullUp: controller.hasNext.value,
                                          controller: controller.refreshController,
                                          onRefresh: controller.refreshPage,
                                          onLoading: controller.loadNextPage,
                                          child: (controller.isLoading)
                                          ? const Center(child: CircularProgressIndicator())
                                          : (controller.dataList.isEmpty)
                                            ? const EmptyStateWidget()
                                            : ScrollConfiguration(
                                              behavior: ScrollConfiguration.of(context).copyWith(
                                                physics: const BouncingScrollPhysics(),
                                                dragDevices: {
                                                  PointerDeviceKind.touch,
                                                  PointerDeviceKind.mouse,
                                                  PointerDeviceKind.trackpad
                                                },
                                              ),
                                              child: ListProductBuilder(
                                                  controller: controller
                                                ),
                                            ),
                                        ),
                                        ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                width: 1,
                                color: AppColors.white.withOpacity(0.2)
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                                height: 70.h,
                                child: Text(
                                  "Order",
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w700
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2,
                                child: Divider(
                                  color: AppColors.white.withOpacity(0.2),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                                height: 30.h-42,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    PrimaryButtonWidget(
                                      margin:  const EdgeInsets.all(0),
                                      buttonText: "Proceed", 
                                      onPressed: () async {
                                        
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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