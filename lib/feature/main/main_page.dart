import 'package:backoffice_tpt_app/feature/category/category_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_financial/dashboard_financial_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_forecasting/dashboard_forecasting_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_transaction/dashboard_transaction_page.dart';
import 'package:backoffice_tpt_app/feature/product/product_page.dart';
import 'package:backoffice_tpt_app/feature/report_financial/report_financial_page.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/report_sale_page.dart';
import 'package:backoffice_tpt_app/feature/report_sale/report_sale_page.dart';
import 'package:backoffice_tpt_app/feature/supplier/supplier_page.dart';
import 'package:backoffice_tpt_app/feature/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:backoffice_tpt_app/feature/main/widgets/side_menu.dart';
import 'package:backoffice_tpt_app/utills/helper/responsive.dart';
import '/feature/home/home_page.dart';
import '../setting/setting_page.dart';

import 'main_controller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) {
        return Scaffold(
          key: controller.scaffoldKey,
          drawer: SideMenu(controller: controller),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: SideMenu(
                      controller: controller,
                    ),
                  ),
                Expanded(
                  flex: 7,
                  child: IndexedStack(
                    index: controller.tabIndex,
                    children: const [
                      HomePage(),
                      SettingPage(),
                      ProductPage(),
                      CategoryPage(),
                      SupplierPage(),
                      UserPage(),
                      SaleReportPage(),
                      PurchaseReportPage(),
                      FinancialReportPage(),
                      TransactionDashboardPage(),
                      FinancialDashboardPage(),
                      ForecastingDashboardPage(),
                    ],
                  ),
                ),
              ],
            ),
          )
        );
      },
    );
  }
}