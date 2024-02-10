import 'package:backoffice_tpt_app/feature/category/category_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_financial/dashboard_financial_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_forecasting/dashboard_forecasting_page.dart';
import 'package:backoffice_tpt_app/feature/dashboard_transaction/dashboard_transaction_page.dart';
import 'package:backoffice_tpt_app/feature/home/home_page.dart';
import 'package:backoffice_tpt_app/feature/product/product_page.dart';
import 'package:backoffice_tpt_app/feature/report_financial/report_financial_page.dart';
import 'package:backoffice_tpt_app/feature/report_purchase/report_purchase_page.dart';
import 'package:backoffice_tpt_app/feature/report_sale/report_sale_page.dart';
import 'package:backoffice_tpt_app/feature/setting/setting_page.dart';
import 'package:backoffice_tpt_app/feature/supplier/supplier_page.dart';
import 'package:backoffice_tpt_app/feature/user/user_page.dart';
import 'package:backoffice_tpt_app/utills/helper/utils.dart';
import 'package:flutter/material.dart';
import 'package:backoffice_tpt_app/model/user.dart';

import '/feature/auth/auth_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  static MainController find = Get.find();
  final AuthController authController = AuthController.find;
  UserData? user;
  int tabIndex = 0;
  List<int> historyIndex = [];

  @override
  void onInit() {
    user = authController.user;
    Utils.loadSideMenuBinding(tabIndex);
    update();
    super.onInit();
  }

  Future<void> refreshPage() async {
    user = authController.user;
    update(['content', 'side-menu']);
    update();
  }

  List<Widget> pageView = [
    const HomePage(),
    const SettingPage(),
    const ProductPage(),
    const CategoryPage(),
    const SupplierPage(),
    const UserPage(),
    const SaleReportPage(),
    const PurchaseReportPage(),
    const FinancialReportPage(),
    const TransactionDashboardPage(),
    const FinancialDashboardPage(),
    const ForecastingDashboardPage(),
  ];

  void changeTabIndex(int index) {
    if (tabIndex != index) {
      if (index != 0) {
        historyIndex.add(index);
      } else if (index == 0) {
        historyIndex.clear();
      }
      Utils.unloadSideMenuBinding(tabIndex);
      Utils.loadSideMenuBinding(index);
    }
    tabIndex = index;
    update(['content', 'side-menu']);
  }
}

